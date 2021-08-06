#ifndef _PRINTF_H
#define _PRINTF_H

#include "types.h"
#include "stdarg.h"

int printf (const char *format, ...);
int vprintf (const char *format, va_list ap);
int snprintf (char *str, size_t size, const char *format, ...);
int vsnprintf (char *str, size_t size, const char *format, va_list ap);

#endif

