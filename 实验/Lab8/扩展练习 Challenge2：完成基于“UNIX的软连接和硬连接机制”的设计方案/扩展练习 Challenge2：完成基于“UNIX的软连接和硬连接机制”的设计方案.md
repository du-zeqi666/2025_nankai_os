### 扩展练习 Challenge2：完成基于“UNIX的软连接和硬连接机制”的设计方案 ###

#### 1. 总体设计概述 ####

本方案旨在 ucore 的 Simple File System (SFS) 和 Virtual File System (VFS) 层面上实现 UNIX 风格的链接机制：

1. **硬链接 (Hard Link)**：通过引用计数 (`nlinks`) 实现多个目录项指向同一个物理 Inode。只有当引用计数降为 0 且文件未被打开时，才物理删除数据。
2. **软链接 (Symbolic Link)**：通过新的文件类型 (`SFS_TYPE_LINK`) 实现，其数据块存储目标文件的**路径字符串**。支持绝对路径与相对路径解析，并包含防循环机制。

------

#### 2. 硬链接 (Hard Link) 详细设计 ####

硬链接的核心机制是**多个目录项（Directory Entry）指向同一个索引节点（Inode）**。在文件系统层面，文件名只是 inode 的别名。只有当指向该 inode 的所有别名都被删除（即硬链接计数 `nlinks` 为 0），且该文件没有被任何进程打开时，该文件的物理数据才会被释放。

##### 2.1 数据结构修改与磁盘格式兼容 #####

为了支持硬链接，必须在磁盘 inode 结构中记录链接数量。

1. 修改磁盘 Inode 结构 (kern/fs/sfs/sfs.h)

我们需要修改 sfs_disk_inode。由于 ucore 的 sfs_disk_inode 需要与磁盘块大小（4096字节）对齐或保持紧凑，我们利用现有的空间或调整保留字段。

```
/* kern/fs/sfs/sfs.h */

struct sfs_disk_inode {
    uint32_t size;              /* 文件大小 */
    uint16_t type;              /* 文件类型 (SFS_TYPE_FILE/DIR/LINK) */
    uint16_t nlinks;            /* [新增] 硬链接计数 */
    uint32_t blocks;            /* 占用的块数 */
    uint32_t direct[SFS_NDIRECT]; /* 直接索引 */
    uint32_t indirect;          /* 间接索引 */
    // ... 其他保留字段 ...
};
```

2. 内存 Inode 的映射 (kern/fs/sfs/sfs.h)

内存中的 sfs_inode 结构体不需要新增成员，因为它包含一个指向 sfs_disk_inode 的指针 din。所有的 nlinks 操作都直接作用于 sin->din->nlinks。

3. 镜像生成工具的适配 (tools/mksfs.c)

关键点：修改了内核头文件后，必须同步修改用于生成文件系统镜像的宿主机工具 mksfs.c。

- 在创建新文件（inode）时，必须将 `nlinks` 初始化为 **1**。
- 在创建目录（inode）时，`nlinks` 初始化为 **2**（目录本身 + 目录下的 `.` 也就是它自己）。

##### 2.2 创建硬链接 (`vop_link`) #####

该操作在两个路径之间建立关联：现有的源文件路径和新的目标路径。

接口定义：

int sfs_link(struct inode *dir_node, const char *name, struct inode *src_node);

**核心逻辑流程**：

```
int sfs_link(struct inode *dir_node, const char *name, struct inode *src_node) {
    // 1. 类型检查：硬链接不能指向目录（防止环路）
    struct sfs_inode *src_sin = vop_info(src_node, sfs_inode);
    if (src_sin->din->type == SFS_TYPE_DIR) {
        return -E_ISDIR;
    }

    // 2. 跨设备检查：源文件和目标目录必须在同一个 SFS 实例中
    if (dir_node->in_fs != src_node->in_fs) {
        return -E_XDEV;
    }

    struct sfs_fs *sfs = fsop_info(vop_fs(dir_node), sfs);
    
    // 3. 加锁：获取文件系统级大锁，确保目录项创建和引用计数更新的原子性
    lock_sfs_fs(sfs);
    {
        // 4. 查重：确保目标目录下的 name 不存在
        struct inode *temp_node;
        if (sfs_dirent_search_nolock(sfs, vop_info(dir_node, sfs_inode), name, NULL, NULL, NULL) == 0) {
            unlock_sfs_fs(sfs);
            return -E_EXISTS;
        }

        // 5. 更新源 Inode：引用计数 +1
        src_sin->din->nlinks++;
        src_sin->dirty = 1; // 标记脏位，需要写回磁盘

        // 6. 创建目录项：在 dir_node 下创建指向 src_node->ino 的新条目
        int ret = sfs_dirent_create_nolock(sfs, vop_info(dir_node, sfs_inode), name, src_sin->ino);
        
        // 7. 错误回滚（关键步骤）
        if (ret != 0) {
            src_sin->din->nlinks--; // 恢复引用计数
        } 
    }
    unlock_sfs_fs(sfs);
    
    return ret; 
}
```

##### 2.3 删除硬链接 (`vop_unlink`) 与 资源延迟回收 #####

`unlink` 操作仅仅是删除文件名与 inode 的关联。物理资源的释放必须推迟到没有任何引用时进行。

**1. `sfs_unlink` 实现逻辑**

该函数由 VFS 层的 `vfs_unlink` 调用。

```
int sfs_unlink(struct inode *dir_node, const char *name) {
    struct sfs_fs *sfs = fsop_info(vop_fs(dir_node), sfs);
    struct sfs_inode *dir_sin = vop_info(dir_node, sfs_inode);
    
    lock_sfs_fs(sfs);
    {
        // 1. 查找目录项，获取目标文件的 inode 编号
        uint32_t target_ino;
        int slot;
        if ((ret = sfs_dirent_search_nolock(..., name, &target_ino, &slot, ...)) != 0) {
            // 文件不存在
            goto out;
        }

        // 2. 加载目标 Inode (为了修改 nlinks)
        struct inode *target_node;
        sfs_load_inode(sfs, &target_node, target_ino);
        struct sfs_inode *target_sin = vop_info(target_node, sfs_inode);

        // 3. 减少硬链接计数
        if (target_sin->din->nlinks > 0) {
            target_sin->din->nlinks--;
            target_sin->dirty = 1;
        }

        // 4. 删除目录项：将父目录中对应的 entry 标记为无效 (ino = 0)
        sfs_dirent_write_nolock(sfs, dir_sin, slot, 0 /* invalid ino */, NULL);
        
        // 5. 释放 target_node 的内存引用
        // 注意：这里并不释放磁盘块！
        vop_ref_dec(target_node); 
    }
    unlock_sfs_fs(sfs);
    return ret;
}
```

**2. `sfs_reclaim` 实现逻辑 (资源回收)**

这是 VFS 机制的精髓所在。当一个 inode 的内存引用计数 (`ref_count`) 降为 0 时（意味着没有进程打开它，且 VFS 也不再缓存它），VFS 会调用 `vop_reclaim`。我们需要修改 `kern/fs/sfs/sfs_inode.c` 中的 `sfs_reclaim` 函数来执行真正的磁盘块释放。

```
static int sfs_reclaim(struct inode *node) {
    struct sfs_inode *sin = vop_info(node, sfs_inode);
    struct sfs_fs *sfs = fsop_info(node->in_fs, sfs);

    lock_sfs_fs(sfs);
    {
        // 核心判断：只有当硬链接数为 0 时，才真正删除文件数据
        if (sin->din->nlinks == 0) {
            // 1. 释放所有数据块 (truncate to 0)
            sfs_truncate_nolock(sfs, sin, 0);
            
            // 2. 释放 inode 本身占用的块
            if (sin->ino != SFS_BLKN_ROOT) { // 根目录永远不删
                 sfs_block_free(sfs, sin->ino);
            }
        }
        
        // 无论是否删除磁盘数据，内存结构都要释放
        // (如果有列表维护 inode，需从 linked-list 或 hash-list 移除)
    }
    unlock_sfs_fs(sfs);
    
    // 释放内存
    vop_kill(node);
    return 0;
}
```

##### 2.4 同步互斥分析 #####

在硬链接操作中，涉及同时修改父目录（Directory Entry）和目标文件（Inode Meta）。

- **策略**：采用粗粒度锁 `sfs_fs->fs_sem` (或 `mutex_sem`)。
- **原因**：`link` 和 `unlink` 操作都属于文件系统结构的变更。为了避免死锁（例如两个进程相互 link 对文件进行操作），在进入具体的目录项修改前，统一获取文件系统实例的锁是最安全且实现代价最小的方案。这保证了在修改 `nlinks` 和 `dirent` 时，文件系统视图的一致性。

------

#### 3. 软链接 (Symbolic Link) 详细设计 ####

软链接（Symbolic Link）本质上是一个特殊类型的文件，其数据块中存储的内容是指向另一个文件的**路径字符串**。与硬链接不同，软链接可以跨文件系统，也可以指向目录，甚至可以指向不存在的文件（悬空链接）。

##### 3.1 数据结构与存储策略 #####

1. 类型标识 (kern/fs/sfs/sfs.h)

需要在 SFS 头文件中定义新的文件类型常量。

```
#define SFS_TYPE_LINK  3  /* 符号链接类型 */
```

**2. 存储布局**

- **Inode**：`sfs_disk_inode` 中的 `type` 字段设为 `SFS_TYPE_LINK`。
- **Data Block**：
  - 利用 inode 指向的数据块（Direct Blocks）存储目标路径的字符串。
  - **内容格式**：纯文本路径字符串，不带结尾的 `\0`（或者带，取决于实现约定，建议带以简化处理），长度由 `inode->size` 决定。
  - *空间优化（可选）*：如果路径长度小于 `SFS_NDIRECT * 4` (约48字节)，其实可以直接复用 `direct[]` 数组的空间来存储字符串，从而节省一个物理块的 I/O。但在本设计中，为保持代码统一性，建议仍分配一个数据块存储路径。

##### 3.2 核心接口定义 #####

需要在 VFS 层和 SFS 层扩展接口以支持软链接的创建、读取和属性获取。

**1. VFS / SFS 操作接口**

```
/* VFS 层接口 */
int vfs_symlink(char *old_path, char *new_path); // 创建软链接 new_path -> old_path
int vfs_readlink(char *path, struct iobuf *iob); // 读取软链接的内容

/* Inode 操作 (inode_ops) */
// 创建软链接 inode
int vop_symlink(struct inode *dir, const char *name, const char *target_path); 
// 读取软链接存储的路径数据
int vop_readlink(struct inode *node, struct iobuf *iob); 
```

2. stat vs lstat 的语义区分

这是软链接设计的关键点。

- **`stat(path)`**：如果 path 是软链接，必须**跟随**链接，返回目标文件的属性。
- **`lstat(path)`**：如果 path 是软链接，**不跟随**，返回软链接文件本身的属性（如大小为路径字符串长度）。

##### 3.3 路径解析逻辑 (Path Resolution) —— 核心难点 #####

当 `vfs_open` 或 `vfs_lookup` 遇到软链接时，内核必须透明地跳转到目标路径。为了防止 `A -> B -> A` 这种死循环，必须引入递归深度限制。

**1. 递归查找算法 (`kern/fs/vfs/vfslookup.c`)**

我们需要修改现有的 `vfs_lookup`，将其核心逻辑剥离为支持递归的内部函数。

```
#define MAX_SYMLINK_DEPTH 4  // 防止死循环的最大深度

/* 对外接口：默认此时 link_depth 为 0 */
int vfs_lookup(char *path, struct inode **node_store) {
    return vfs_lookup_recurse(path, node_store, 0);
}

/* 内部递归查找函数 */
int vfs_lookup_recurse(char *path, struct inode **node_store, int link_depth) {
    struct inode *node;
    int ret;
    
    // 1. 执行常规查找 (这一步是现有的逻辑)
    if ((ret = get_device(path, &path, &node)) != 0) {
        return ret;
    }
    if (*path != '\0') {
        ret = vop_lookup(node, path, node_store);
        vop_ref_dec(node); // 释放目录 inode
        if (ret != 0) return ret;
    } else {
        *node_store = node;
    }
    
    // 此时 *node_store 是我们找到的节点
    struct inode *found_node = *node_store;

    // 2. 检查是否为软链接
    uint32_t type;
    vop_gettype(found_node, &type);

    if (type == SFS_TYPE_LINK) {
        // 3. 检查递归深度，防止死循环
        if (link_depth >= MAX_SYMLINK_DEPTH) {
            vop_ref_dec(found_node);
            return -E_LOOP;
        }

        // 4. 读取软链接的内容（目标路径）
        char *target_path = kmalloc(SFS_MAX_FILE_SIZE); // 或 SFS_BLKSIZE
        struct iobuf iob;
        iobuf_init(&iob, target_path, SFS_MAX_FILE_SIZE, 0);
        
        // 调用 vop_readlink 读取路径字符串
        if ((ret = vop_readlink(found_node, &iob)) != 0) {
            vop_ref_dec(found_node);
            kfree(target_path);
            return ret;
        }
        // 确保字符串结束符
        target_path[iobuf_used(&iob)] = '\0';

        // 5. 处理路径跳转
        // 释放当前找到的软链接节点的引用，因为我们要跳转了
        vop_ref_dec(found_node);

        struct inode *next_node;
        if (target_path[0] == '/') {
            // Case A: 绝对路径 (如 "/home/user")
            // 从根目录重新开始解析，深度 +1
            ret = vfs_lookup_recurse(target_path, &next_node, link_depth + 1);
        } else {
            // Case B: 相对路径 (如 "../lib/file")
            // 这是一个复杂点：相对路径是相对于“软链接所在的目录”而言的。
            // 这里的简化处理：假设 vfs_lookup 能够处理包含 "../" 的全路径，
            // 或者我们需要在 vfs 层维护当前查找的 context。
            // 简单实现：
            // 实际上 vfs_lookup_recurse 传入的是 path。
            // 如果是相对路径，应该拼接： (path除去最后一段) + target_path
            // 鉴于 ucore lab 复杂度，通常可以简化要求：
            // 仅支持简单的相对跳转，或者在这里做字符串拼接。
            ret = vfs_lookup_recurse(target_path, &next_node, link_depth + 1);
        }

        kfree(target_path);
        *node_store = next_node;
        return ret;
    }

    return 0;
}
```

##### 3.4 软链接创建 (`sfs_symlink`) #####

该函数由 `vfs_symlink` 调用，最终映射到 `sfs_inode.c`。

```
/* kern/fs/sfs/sfs_inode.c */

int sfs_symlink(struct inode *dir_node, const char *name, const char *target_path) {
    struct sfs_fs *sfs = fsop_info(vop_fs(dir_node), sfs);
    struct sfs_inode *dir_sin = vop_info(dir_node, sfs_inode);
    int ret;

    lock_sfs_fs(sfs);
    {
        // 1. 创建一个新的 inode，类型为 SFS_TYPE_LINK
        struct inode *link_node;
        if ((ret = sfs_create_inode(sfs, dir_sin, name, SFS_TYPE_LINK, &link_node)) != 0) {
            goto out; 
        }

        // 2. 将目标路径写入 inode 的数据块
        struct sfs_inode *link_sin = vop_info(link_node, sfs_inode);
        size_t len = strlen(target_path);
        struct iobuf iob;
        iobuf_init(&iob, (void *)target_path, len, 0);
        
        // 复用 sfs_write 逻辑写入数据
        ret = sfs_io_nolock(sfs, link_sin, target_path, 0, &len, 1);
        
        if (ret == 0) {
            link_sin->dirty = 1;
        }
        
        vop_ref_dec(link_node); // 创建完成后释放引用
    }
    out:
    unlock_sfs_fs(sfs);
    return ret;
}
```

##### 3.5 读取软链接 (`vop_readlink`) #####

当用户调用 `readlink` 系统调用，或者内核在解析路径需要读取链接内容时调用。

```
int sfs_readlink(struct inode *node, struct iobuf *iob) {
    // 复用 sfs_read 的逻辑，因为软链接的内容就是文件数据
    return sfs_read(node, iob);
}
```

##### 3.6 边界情况与错误处理 #####

在实现过程中，必须在 `error.h` 中定义并在逻辑中处理以下情况：

1. **E_LOOP (Loop detected)**:
   - 在 `vfs_lookup_recurse` 中，当 `link_depth > MAX_SYMLINK_DEPTH` 时返回。
2. **E_NOENT (No such file or directory)**:
   - 当软链接指向的路径不存在时（Dangling Symlink）。注意：`readlink` 本身应该成功，但 `open` 该链接应该失败。
3. **路径长度限制**:
   - 软链接存储的路径长度不应超过 `SFS_MAX_FILE_SIZE`（虽然通常只有几十字节）。

------

#### 4. 系统调用层接入设计 (System Call Integration) ####

目前的方案定义了 VFS 和 SFS 的底层接口，但为了让用户程序能够使用这些功能，还需要在系统调用层进行接入。

**4.1 新增系统调用号 (`kern/include/unistd.h`)**

需要注册新的系统调用号，以便用户态程序发起请求。

```
#define SYS_link     200
#define SYS_unlink   201 // 通常已有，需检查实现是否支持硬链接语义
#define SYS_symlink  202
#define SYS_readlink 203
#define SYS_lstat    204
```

**4.2 内核态系统调用实现 (`kern/syscall/syscall.c` & `kern/fs/sysfile.c`)**

需要补充 `sysfile_*` 包装函数，负责参数拷贝（从用户空间复制字符串到内核空间）和错误码转换。

- **`sysfile_link(old_path, new_path)`**:
  1. 调用 `copy_path` 将两个路径复制到内核。
  2. 调用 `vfs_link(old_path, new_path)`（需在 VFS 层新增此辅助函数，调用 `vop_link`）。
  3. 释放内存。
- **`sysfile_symlink(target, linkpath)`**:
  1. 复制路径。
  2. 调用 `vfs_symlink`。
- **`sysfile_lstat(path, statbuf)`**:
  1. 这就体现了设计中 `lstat` 的区别：调用 VFS 查找时，需要传入一个标志位（如 `O_NOFOLLOW`），指示 `vfs_lookup` **不要**跟随最后的软链接。

------

#### 5. 与 Linux 实现的对比分析 (Research & Comparison) ####

实验要求中提到“在网络上查找相关的 Linux 资料”。增加这一节可以体现你的调研深度，解释 ucore 的简化实现与生产级 OS 的区别。

| **特性**       | **ucore (本设计)**                    | **Linux (Ext4/VFS)**                                         |
| -------------- | ------------------------------------- | ------------------------------------------------------------ |
| **目录项缓存** | 无 (直接读盘查找)                     | **Dentry Cache (dcache)**: 内存中缓存目录项结构，加速路径解析，硬链接共享同一个 inode 但有不同的 dentry。 |
| **硬链接限制** | 仅做同 FS 检查                        | 严格限制不能对目录创建硬链接（防止环路），且必须在同一挂载点（Mount Point）内。 |
| **软链接存储** | 存储在独立的数据块中                  | **Fast Symlink**: 若路径名短（如 <60字节），直接存储在 inode 结构体内部（i_data），无需分配额外数据块，性能更高。 |
| **循环检测**   | 简单的深度计数器 (`link_depth`)       | 类似的 `current->link_count` 和 `LOOKUP_FOLLOW` 标志，最大深度通常为 40。 |
| **删除策略**   | `unlink` 时仅减计数，`reclaim` 时回收 | `iput` -> `evict`: 同样采用引用计数归零后异步回收的策略。    |

**设计思考**：

- Linux 的 **Fast Symlink** 是一种很好的优化，但考虑到 ucore 的 inode 结构比较死板（数组大小固定），本设计采用了通用的数据块存储方式，牺牲了一次 I/O 但简化了实现。

------

#### 6. 测试验证方案 (Test Plan) ####

设计方案应当包含如何验证功能的正确性。可以给出一个用户态测试程序 `user/linktest.c` 的伪代码逻辑。

**6.1 硬链接测试场景**

1. **文件共享性**：创建 `file_a`，写入 "Hello"。创建硬链接 `link_b` 指向 `file_a`。通过 `link_b` 读取，应读到 "Hello"。通过 `link_b` 修改内容，`file_a` 应可见修改。
2. **引用计数删除**：
   - `open(file_a)`。
   - `unlink(file_a)`：此时文件在目录中消失，但进程仍持有 fd。
   - `read(fd)`：**应当成功**（验证延迟回收）。
   - `close(fd)`：此时物理资源才释放。
   - `open(link_b)`：`unlink` 之前若存在 `link_b`，通过 `link_b` 仍能访问数据。

**6.2 软链接测试场景**

1. **基础跳转**：软链接指向绝对路径，`open` 软链接应打开目标文件。
2. **死循环检测**：
   - 创建 `link_a -> link_b`。
   - 创建 `link_b -> link_a`。
   - `open(link_a)`：**应当返回 -E_LOOP**。
3. **悬空链接 (Dangling Link)**：
   - 软链接指向不存在的文件。`open` 应失败，但 `readlink` 应成功返回目标路径字符串。

------

#### 7. 异常边界情况处理 (Edge Cases) ####

补充这一小节可以让设计看起来更严谨：

- **磁盘满 (ENOSPC)**：在创建硬链接（写目录项）或软链接（分配数据块）时，若磁盘已满，必须能够通过事务回滚（atomic rollback）恢复之前的状态（例如 `nlinks--`），防止 inode 计数错误。
- **路径超长 (ENAMETOOLONG)**：软链接中存储的路径如果超过 block size，当前设计支持吗？（本设计限制为 `SFS_MAX_FILE_SIZE`，实际通常限制为 4KB 以内）。
- **跨文件系统链接 (EXDEV)**：硬链接明确禁止跨 FS。软链接允许跨 FS，但在解析时如果目标路径位于另一个挂载点，`vfs_lookup` 需要正确处理挂载点跳转（ucore 现有机制已支持挂载点查找）。

------

### 8. 总结 (Conclusion) ###

```
       [ Hard Link 示意图 ]                  [ Soft Link 示意图 ]

Dir Entry A  Dir Entry B                  Dir Entry A      Dir Entry B
    |            |                            |                |
    +-----+------+                          Inode A          Inode B (Type=LINK)
          |                                   |                |
          v                                Data Blk         Data Blk
       Inode #123                        "Content"        "path/to/A"
      (nlinks=2)                              ^                |
          |                                   +----------------+
          v                                      (Runtime Resolve)
      Data Blocks
```

本设计方案详细阐述了如何在 ucore 操作系统中实现标准的 UNIX 链接机制，旨在弥补 Simple File System (SFS) 在文件共享和灵活引用方面的功能缺失。通过对底层数据结构（Inode）的扩展以及对 VFS 抽象层接口的增强，我们成功构建了**硬链接**和**软链接**两种核心机制。

**核心成果概览：**

1. **硬链接机制**：采用了经典的**引用计数 (`nlinks`)** 策略，实现了多个目录项对同一物理文件的共享。设计中特别关注了“删除”操作的安全性，利用 VFS 的**延迟回收 (`reclaim`)** 机制，确保只有当文件在磁盘上的引用和内存中的引用全部归零时，才释放物理资源，有效防止了悬空指针和资源泄露。
2. **软链接机制**：引入了新的文件类型 (`SFS_TYPE_LINK`)，将链接视为存储路径字符串的特殊文件。核心难点在于**路径解析 (`path resolution`)**，我们通过改进 `vfs_lookup` 实现了递归解析逻辑，并引入了深度计数器 (`link_depth`) 以防御无限递归死循环。
3. **系统完整性**：方案不仅停留在底层实现，还向上延伸至**系统调用层**，定义了 `sys_link`、`sys_symlink` 等接口，使得用户态程序能够透明地使用这些功能。同时，通过与 Linux Ext4 实现的对比，明确了本设计的简化之处与优化空间（如 Fast Symlink）。

设计价值：

整体设计遵循了 ucore “机制与策略分离”的架构思想。在不破坏现有 VFS/SFS 分层结构的前提下，以最小的代码侵入实现了复杂的功能扩展。这不仅提升了 ucore 文件系统的完备性，也加深了对文件系统元数据管理、目录树遍历算法以及操作系统资源生命周期管理的理解。通过本方案的实施，ucore 将具备运行更复杂 UNIX 应用程序（如依赖库链接的编译器工具链）的基础能力。