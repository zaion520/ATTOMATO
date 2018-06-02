
KERNEL_HEADERS=-I/root/advancedtomat/release/src-rt-6.x.4708/linux/linux-2.6.36/include

AR=ar
RANLIB=arm-brcm-linux-uclibcgnueabi-ranlib

CC=arm-brcm-linux-uclibcgnueabi-gcc
CFLAGS = -Wall -g $(KERNEL_HEADERS)

prefix=
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

libbridge_SOURCES= \
	libbridge_devif.c \
	libbridge_if.c \
	libbridge_init.c \
	libbridge_misc.c 

libbridge_OBJECTS=$(libbridge_SOURCES:.c=.o)

all:	libbridge.a

# At present there is no need for a bridge-utils-devel package
install:


clean:
	rm -f *.o libbridge.a

libbridge.a:	$(libbridge_OBJECTS)
	$(AR) rcs $@ $(libbridge_OBJECTS)
	$(RANLIB) $@

%.o: %.c libbridge.h libbridge_private.h
	$(CC) $(CFLAGS) $(INCLUDE) -c $<

libbridge_compat.o:	libbridge_compat.c if_index.c
	$(CC) $(CFLAGS) -c libbridge_compat.c

