-include ../../config.mk
-include ../../tools/kconfig/.config

PREFIX?=$(PWD)/build
CROSS_COMPILE?=arm-none-eabi-
CC?=gcc
ARCH?=stm32
OBJS:=fossa.o
CFLAGS=-Iconfig $(EXTRA_CFLAGS) $(PLATFORM_CFLAGS) -I $(PREFIX)/include -DMONGOOSE_NO_FILESYSTEM -DMONGOOSE_NO_MMAP -DNS_DISABLE_THREADS -DMONGOOSE_NO_THREADS -DNS_DISABLE_SOCKETPAIR -DMONGOOSE_NO_SOCKETPAIR -DPICOTCP
#CFLAGS += -DNS_ENABLE_DEBUG
#CFLAGS += -DFREERTOS

all: $(PREFIX)/lib/libfossa.a

%.o: %.c 
	$(CC) -c $(CFLAGS) -I . -o $@ $<

$(PREFIX)/lib/libfossa.a: $(OBJS)
	cp *.h $(PREFIX)/include
	@$(CROSS_COMPILE)ar cru $@ $(OBJS)
	@$(CROSS_COMPILE)ranlib $@
	
clean:
	rm -f *.o *.a
