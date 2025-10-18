#ifndef __KERN_MM_SLUB_H__
#define __KERN_MM_SLUB_H__


#include <defs.h>
#include <list.h>
#include <pmm.h>

/* le2slab: ����ڵ�תΪ Slab �ṹָ�� */
#define le2slab(le, member)         \
    to_struct((le), Slab, member)


#endif /* !__KERN_MM_SLUB_H__ */
