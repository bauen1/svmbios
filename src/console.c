#include <stdarg.h>
#include <stddef.h>

#include <cpu.h>

char * utoa(unsigned int value, char *str, int base, int width) {
        int i = 0;

        if ((base < 2) || (base > 36)) {
                str[0] = 0;
                return NULL;
        }

        do {
                str[i++] = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz"[35 + value % base];
                value = value / base;
        } while (value != 0);

        for (; i < width; i++) {
                str[i] = '0';
        }

        str[i] = 0;

        i--;
        for (int j = 0; j < i; j++, i--) {
                char c = str[j];
                str[j] = str[i];
                str[i] = c;
        }
        return str;
}

char * itoa(int num, char *str, int base, int width) {
        if ((base == 10) && (num < 0)) {
                return utoa((unsigned)-num, str, base, width);
        } else {
                return utoa((unsigned)num, str, base, width);
        }

}

static void debug_out(const char c) {
	outb(0xe9, c);
}

char getc() {
	return 0;
}

void putc(const char c) {
	debug_out(c);
}

void puts(const char *s) {
	for (int i = 0; s[i] != 0; i++) {
		putc(s[i]);
	}
}

void printf(const char *fmt, ...) {
	va_list args;
	va_start(args, fmt);

	char buf[256]; // probably too much
	char *s;

	while (*fmt != 0) {
		if (*fmt == '%') {
			fmt++;
			if (*fmt == 0) {
				break;
			}
			unsigned int width = 0;
			while ((*fmt >= '0') && (*fmt <= '9')) {
				width = width * 10 + (*fmt - '0');
				fmt++;
			}
			switch (*fmt) {
				case '%':
					putc('%');
					break;
				case 's':
					s = va_arg(args, char *);
					if (s == NULL) {
						puts("(null)");
					} else {
						puts(s);
					}
					break;
				case 'i':
				case 'd':
					itoa(va_arg(args, int), &buf[0], 10, width);
					puts(buf);
					break;
				case 'x':
					itoa(va_arg(args, int), &buf[0], 16, width);
					puts(buf);
					break;
				default:
					putc(*fmt);
			}
		} else {
			putc(*fmt);
		}
		fmt++;
	}

	va_end(args);
}
