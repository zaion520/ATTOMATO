KRB5LIBS=
LDAP_LIBS=
LIBS= -lnetapi -ltdb -ltalloc
DEVELOPER_CFLAGS=-DDEBUG_PASSWORD -DDEVELOPER -g -Wall -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings
CCFLAGS=-I../ -L../../../bin  -DLINUX26 -DCONFIG_BCMWL5 -DCONFIG_BCMWL6 -DCONFIG_BCMWL6A -DPART_JFFS2_GAP=0UL -pipe -fno-strict-aliasing -DBCMWPA2 -DBCMARM -marm -DTCONFIG_NVRAM_64K -DLINUX_KERNEL_VERSION=132644 -O3 -ffunction-sections -fdata-sections -I/root/advancedtomat/release/src-rt-6.x.4708/router/libiconv/include -DBCMARM $(FLAGS) -D_SAMBA_BUILD_=3 $(GTK_FLAGS)
CC=arm-brcm-linux-uclibcgnueabi-gcc
PICFLAG=-fPIC
LDFLAGS= -ffunction-sections -fdata-sections -Wl,--gc-sections -L/root/advancedtomat/release/src-rt-6.x.4708/router/libiconv/lib/.libs -lgcc_s -ldl -L./bin
DYNEXP=-Wl,--export-dynamic
NETAPI_LIBS=$(LIBS) $(KRB5LIBS) $(LDAP_LIBS)
CMDLINE_LIBS=$(NETAPI_LIBS) $(POPT_OBJ)

# Compile a source file.
COMPILE_CC = $(CC) -I. $(CCFLAGS) $(PICFLAG) -c $< -o $@
COMPILE = $(COMPILE_CC)

PROGS = bin/netapitest

all: $(PROGS)

MAKEDIR = || exec false; \
	  if test -d "$$dir"; then :; else \
	  echo mkdir "$$dir"; \
	  mkdir -p "$$dir" >/dev/null 2>&1 || \
	  test -d "$$dir" || \
	  mkdir "$$dir" || \
	  exec false; fi || exec false

BINARY_PREREQS = bin/.dummy

bin/.dummy:
	@if (: >> $@ || : > $@) >/dev/null 2>&1; then :; else \
	  dir=bin $(MAKEDIR); fi
	@: >> $@ || : > $@ # what a fancy emoticon!

.c.o:
	@if (: >> $@ || : > $@) >/dev/null 2>&1; then rm -f $@; else \
	 dir=`echo $@ | sed 's,/[^/]*$$,,;s,^$$,.,'` $(MAKEDIR); fi
	@echo Compiling $*.c
	@$(COMPILE) && exit 0;\
		echo "The following command failed:" 1>&2;\
		echo "$(COMPILE_CC)" 1>&2;\
		$(COMPILE_CC) >/dev/null 2>&1

CMDLINE_OBJ = common.o
NETAPIBUFFER_OBJ = netapibuffer.o
NETAPITEST_OBJ = netapitest.o netlocalgroup.o netuser.o netgroup.o netdisplay.o netshare.o netfile.o netserver.o $(CMDLINE_OBJ)

bin/netapitest: $(BINARY_PREREQS) $(NETAPITEST_OBJ)
	@echo Linking $@
	@$(CC) $(CCFLAGS) -o $@ $(NETAPITEST_OBJ) $(LDFLAGS) $(DYNEXP) $(CMDLINE_LIBS)

clean:
	-rm -f $(PROGS)
	-rm -f core */*~ *~ \
		*/*.o */*/*.o */*/*/*.o

