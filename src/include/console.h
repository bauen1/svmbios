#ifndef CONSOLE_H
#define CONSOLE_H 1

char getc();
void putc(const char c);
void puts(const char *s);

__attribute__((format(print, 1, 2)))
void printf(const char *fmt, ...);

#endif
