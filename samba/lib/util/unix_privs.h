#ifndef __LIB_UTIL_UNIX_PRIVS_H__
#define __LIB_UTIL_UNIX_PRIVS_H__

#undef _PRINTF_ATTRIBUTE
#define _PRINTF_ATTRIBUTE(a1, a2) PRINTF_ATTRIBUTE(a1, a2)
/* This file was automatically generated by mkproto.pl. DO NOT EDIT */

#ifndef _PUBLIC_
#define _PUBLIC_
#endif


/* The following definitions come from lib/util/unix_privs.c  */

void *root_privileges(void);
#undef _PRINTF_ATTRIBUTE
#define _PRINTF_ATTRIBUTE(a1, a2)

#endif /* __LIB_UTIL_UNIX_PRIVS_H__ */
