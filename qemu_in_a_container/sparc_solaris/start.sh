#!/bin/bash

if [ ! -f ./disk.img ]; then
#  dd if=/dev/zero of=/tmp/part.img bs=512 count=91669
#  mformat -i /tmp/part.img -h 32 -t 32 -n 64 -c 1
  qemu-img create -f raw ./disk.img 5G
#  parted /disk.img -s -a minimal mklabel gpt
#  parted /disk.img -s -a minimal mkpart EFI FAT16 2048s 93716s
#  parted /disk.img -s -a minimal toggle 1 boot
#  mmd -i /tmp/part.img ::/EFI
#  mmd -i /tmp/part.img ::/EFI/BOOT
#  mcopy -i /tmp/part.img /BOOTX64.EFI ::/EFI/BOOT
#  dd if=/tmp/part.img of=/disk.img bs=512 count=91669 seek=2048 conv=notrunc
fi

/usr/bin/qemu-system-sparc \
-nographic \
-serial 'mon:stdio' \
-readconfig ./vm.ini \
-writeconfig ./vm.ini \
# qemu config file


