CC      = gcc
CFLAGS  = -Wall -fno-builtin -nostdinc -nostdlib -m32 -ggdb3
LD      = ld
AS		= as

OBJFILES = \
	src/loader.o  \
	common/printf.o  \
	common/screen.o  \
	src/pci.o \
	src/kernel.o

image:
	@echo "Creating hdd.img..."
	@dd if=/dev/zero of=./hdd.img bs=512 count=16065 1>/dev/null 2>&1

	@echo "Creating bootable first FAT32 partition..."
	@losetup /dev/loop24 ./hdd.img
	@(echo c; echo u; echo n; echo p; echo 1; echo ;  echo ; echo a; echo 1; echo t; echo c; echo w;) | fdisk /dev/loop24 1>/dev/null 2>&1 || true

#	@echo    `echo \`fdisk -lu /dev/loop24 | sed -n 9p | awk '{print $3}'\`*512 | bc` 
	@echo `echo \`fdisk -lu /dev/loop24 | sed -n 9p | awk '{print $$3}'\`*512 | bc`
	@echo `echo \`fdisk -lu /dev/loop24 | sed -n 9p | awk '{print $$4}'\`*512 | bc`
	@echo "Mounting partition to /dev/loop25..."
	@losetup /dev/loop25 ./hdd.img \
    --offset    `echo \`fdisk -lu /dev/loop24 | sed -n 9p | awk '{print $$3}'\`*512 | bc` \
    --sizelimit `echo \`fdisk -lu /dev/loop24 | sed -n 9p | awk '{print $$4}'\`*512 | bc`
	@losetup -d /dev/loop24

	@echo "Format partition..."
	@mkdosfs /dev/loop25

	@echo "Copy kernel and grub files on partition..."
	@mkdir -p tempdir
	@mount /dev/loop25 tempdir
	@mkdir tempdir/boot
	@cp -r ./grub tempdir/boot/
	@cp kernel.bin tempdir/
	@sleep 1
	@umount /dev/loop25
	@rm -r tempdir
	@losetup -d /dev/loop25

	@echo "Installing GRUB..."
	@echo "device (hd0) hdd.img \n \
	       root (hd0,0)         \n \
	       setup (hd0)          \n \
	       quit\n" | ./grub/grub --batch 1>/dev/null
	@echo "Done!"

all: kernel.bin
rebuild: clean all
.s.o:
	$(AS) --32 -o $@ $<
.c.o:
	$(CC) -Iinclude $(CFLAGS) -o $@ -c $<
kernel.bin: $(OBJFILES)
	$(LD) --verbose -m elf_i386 -T src/linker.ld -o $@ $^
	cp $@ $@.dbg
	strip $@
clean:
	rm -f $(OBJFILES) hdd.img kernel.bin

