
KERNEL_HEADERS=-I/root/advancedtomat/release/src-rt-6.x.4708/linux/linux-2.6.36/include

CC=arm-brcm-linux-uclibcgnueabi-gcc
CFLAGS= -Wall -Os -g -DLINUX26 -DCONFIG_BCMWL5 -DCONFIG_BCMWL6 -DCONFIG_BCMWL6A -DPART_JFFS2_GAP=0UL -pipe -fno-strict-aliasing -DBCMWPA2 -DBCMARM -marm  -DTCONFIG_NVRAM_64K -DLINUX_KERNEL_VERSION=132644
LDFLAGS=
INCLUDE=-I../libbridge $(KERNEL_HEADERS) 
LIBS= -L ../libbridge -lbridge 

prefix=
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
sbindir=${exec_prefix}/sbin
mandir=${prefix}/share/man

INSTALL=/usr/bin/install -c


common_SOURCES= brctl_cmd.c brctl_disp.c 
brctl_SOURCES=  brctl.c $(common_SOURCES)

common_OBJECTS= $(common_SOURCES:.c=.o)
brctl_OBJECTS= $(brctl_SOURCES:.c=.o)

OBJECTS= $(common_OBJECTS) $(brctl_OBJECTS)

PROGRAMS= brctl 


all:	$(PROGRAMS)

install: $(PROGRAMS)
	mkdir -p $(DESTDIR)$(sbindir)
	$(INSTALL) -m 755 $(PROGRAMS) $(DESTDIR)$(sbindir)

brctl:	$(brctl_OBJECTS) ../libbridge/libbridge.a
	$(CC) $(LDFLAGS) $(brctl_OBJECTS) $(LIBS) -o brctl

%.o: %.c brctl.h
	$(CC) $(CFLAGS) $(INCLUDE) -c $< 

clean:
	rm -f *.o brctl core

