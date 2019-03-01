#!/bin/bash

if [ ! -f /disk.img ]; then
#  dd if=/dev/zero of=/tmp/part.img bs=512 count=91669
#  mformat -i /tmp/part.img -h 32 -t 32 -n 64 -c 1
  qemu-img create -f raw /disk.img 100G
#  parted /disk.img -s -a minimal mklabel gpt
#  parted /disk.img -s -a minimal mkpart EFI FAT16 2048s 93716s
#  parted /disk.img -s -a minimal toggle 1 boot
#  mmd -i /tmp/part.img ::/EFI
#  mmd -i /tmp/part.img ::/EFI/BOOT
#  mcopy -i /tmp/part.img /BOOTX64.EFI ::/EFI/BOOT
#  dd if=/tmp/part.img of=/disk.img bs=512 count=91669 seek=2048 conv=notrunc
fi

/usr/bin/qemu-system-x86_64 \
-name guest=qemu_in_a_container,debug-threads=on \
-machine pc-q35-2.11,usb=off,vmport=off,dump-guest-core=off \
-cpu qemu64,vmx=off \
-drive file=/OVMF.fd,if=pflash,format=raw,unit=0,readonly=on \
-drive file=/OVMF.vars,if=pflash,format=raw,unit=1 \
-m 2048 \
-smp 4,sockets=1,cores=4,threads=1 \
-no-user-config \
-nodefconfig \
-nodefaults \
-rtc base=localtime,driftfix=slew \
-no-hpet \
-no-shutdown \
-global ICH9-LPC.disable_s3=1 \
-global ICH9-LPC.disable_s4=1 \
-device i82801b11-bridge,id=pci.1,bus=pcie.0,addr=0x1e \
-device pci-bridge,chassis_nr=2,id=pci.2,bus=pci.1,addr=0x0 \
-device pcie-root-port,port=0x10,chassis=3,id=pci.3,bus=pcie.0,multifunction=on,addr=0x2 \
-device pcie-root-port,port=0x11,chassis=4,id=pci.4,bus=pcie.0,addr=0x2.0x1 \
-device pcie-root-port,port=0x12,chassis=5,id=pci.5,bus=pcie.0,addr=0x2.0x2 \
-device pcie-root-port,port=0x13,chassis=6,id=pci.6,bus=pcie.0,addr=0x2.0x3 \
-device ich9-usb-ehci1,id=usb,bus=pcie.0,addr=0x1d.0x7 \
-device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pcie.0,multifunction=on,addr=0x1d \
-device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pcie.0,addr=0x1d.0x1 \
-device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pcie.0,addr=0x1d.0x2 \
-drive file=/disk.img,format=raw,if=none,id=drive-virtio-disk0,cache=unsafe \
-device virtio-blk-pci,scsi=off,bus=pci.4,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=0 \
-netdev user,id=hostnet0 \
-device e1000,netdev=hostnet0,id=net0,mac=52:54:00:d9:d6:73,bus=pci.2,addr=0x1 \
-vga none \
-display none \
-device virtio-serial-pci \
-serial 'mon:stdio' \
-drive if=none,id=stick,file=/install64.fs  \
-device usb-storage,bus=usb.0,drive=stick,bootindex=1 \
-msg timestamp=on
