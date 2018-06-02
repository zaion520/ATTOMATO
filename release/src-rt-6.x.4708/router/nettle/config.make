# Makefile settings shared between Makefiles.

CC = arm-brcm-linux-uclibcgnueabi-gcc
CXX = arm-linux-g++
CFLAGS = -O2 -Wall -DLINUX26 -DCONFIG_BCMWL5 -DCONFIG_BCMWL6 -DCONFIG_BCMWL6A -DPART_JFFS2_GAP=0UL -pipe -fno-strict-aliasing -DBCMWPA2 -DBCMARM -marm  -DTCONFIG_NVRAM_64K -DLINUX_KERNEL_VERSION=132644 -fPIC -ffunction-sections -fdata-sections -ggdb3 -Wno-pointer-sign -Wall -W   -Wmissing-prototypes -Wmissing-declarations -Wstrict-prototypes   -Wpointer-arith -Wbad-function-cast -Wnested-externs
CXXFLAGS = -g -O2
CCPIC = -fpic
CPPFLAGS = -I/root/advancedtomato-arm/release/src-rt-6.x.4708/router/gmp
DEFS = -DHAVE_CONFIG_H
LDFLAGS = -L/root/advancedtomato-arm/release/src-rt-6.x.4708/router/gmp/.libs -ffunction-sections -fdata-sections -Wl,--gc-sections -fPIC
LIBS = 
LIBOBJS = 
EMULATOR = 
NM = arm-brcm-linux-uclibcgnueabi-nm

OBJEXT = o
EXEEXT = 

CC_FOR_BUILD = gcc -O -g
EXEEXT_FOR_BUILD = 

DEP_FLAGS = -MT $@ -MD -MP -MF $@.d
DEP_PROCESS = true

PACKAGE_BUGREPORT = nettle-bugs@lists.lysator.liu.se
PACKAGE_NAME = nettle
PACKAGE_STRING = nettle 3.4
PACKAGE_TARNAME = nettle
PACKAGE_VERSION = 3.4

LIBNETTLE_MAJOR = 6
LIBNETTLE_MINOR = 4
LIBNETTLE_SONAME = $(LIBNETTLE_FORLINK).$(LIBNETTLE_MAJOR)
LIBNETTLE_FILE = $(LIBNETTLE_SONAME).$(LIBNETTLE_MINOR)
LIBNETTLE_FILE_SRC = $(LIBNETTLE_FORLINK)
LIBNETTLE_FORLINK = libnettle.so
LIBNETTLE_LIBS = 
LIBNETTLE_LINK = $(CC) $(CFLAGS) $(LDFLAGS) -shared -Wl,-soname=$(LIBNETTLE_SONAME)

LIBHOGWEED_MAJOR = 4
LIBHOGWEED_MINOR = 4
LIBHOGWEED_SONAME = $(LIBHOGWEED_FORLINK).$(LIBHOGWEED_MAJOR)
LIBHOGWEED_FILE = $(LIBHOGWEED_SONAME).$(LIBHOGWEED_MINOR)
LIBHOGWEED_FILE_SRC = $(LIBHOGWEED_FORLINK)
LIBHOGWEED_FORLINK = libhogweed.so
LIBHOGWEED_LIBS = libnettle.so $(LIBS)
LIBHOGWEED_LINK = $(CC) $(CFLAGS) $(LDFLAGS) -shared -Wl,-soname=$(LIBHOGWEED_SONAME)

NUMB_BITS = 32

AR = arm-brcm-linux-uclibcgnueabi-ar
ARFLAGS = cru
AUTOCONF = autoconf
AUTOHEADER = autoheader
M4 = /usr/bin/m4
MAKEINFO = makeinfo
RANLIB = arm-brcm-linux-uclibcgnueabi-ranlib
LN_S = ln -s

prefix	=	/root/advancedtomato-arm/release/src-rt-6.x.4708/router/nettle
exec_prefix =	${prefix}
datarootdir =	${prefix}/share
bindir =	${exec_prefix}/bin
libdir =	${exec_prefix}/lib
includedir =	${prefix}/include
infodir =	${datarootdir}/info

# PRE_CPPFLAGS and PRE_LDFLAGS lets each Makefile.in prepend its own
# flags before CPPFLAGS and LDFLAGS. While EXTRA_CFLAGS are added at the end.

COMPILE = $(CC) $(PRE_CPPFLAGS) $(CPPFLAGS) $(DEFS) $(CFLAGS) $(EXTRA_CFLAGS) $(DEP_FLAGS)
COMPILE_CXX = $(CXX) $(PRE_CPPFLAGS) $(CPPFLAGS) $(DEFS) $(CXXFLAGS) $(DEP_FLAGS)
LINK = $(CC) $(CFLAGS) $(PRE_LDFLAGS) $(LDFLAGS)
LINK_CXX = $(CXX) $(CXXFLAGS) $(PRE_LDFLAGS) $(LDFLAGS)

# Default rule. Must be here, since config.make is included before the
# usual targets.
default: all

# For some reason the suffixes list must be set before the rules.
# Otherwise BSD make won't build binaries e.g. aesdata. On the other
# hand, AIX make has the opposite idiosyncrasies to BSD, and the AIX
# compile was broken when .SUFFIXES was moved here from Makefile.in.

.SUFFIXES:
.SUFFIXES: .asm .c .$(OBJEXT) .html .dvi .info .exe .pdf .ps .texinfo

# Disable builtin rule
%$(EXEEXT) : %.c
.c:

# Keep object files
.PRECIOUS: %.o

.PHONY: all check install uninstall clean distclean mostlyclean maintainer-clean distdir \
	all-here check-here install-here clean-here distclean-here mostlyclean-here \
	maintainer-clean-here distdir-here \
	install-shared install-info install-headers \
	uninstall-shared uninstall-info uninstall-headers \
	dist distcleancheck
