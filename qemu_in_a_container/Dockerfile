FROM ubuntu

RUN apt-get update

RUN apt-get -y install qemu-system-x86 curl wget ovmf 

RUN wget "https://boot.alpinelinux.org/alpine-ipxe/x86_64/ipxe.efi"

RUN cp /usr/share/ovmf/OVMF.fd . 

RUN dd of=ovmf.var bs=1k conv=notrunc if=OVMF.fd

CMD /usr/bin/qemu-system-x86_64 -display none -cpu qemu64,-vmx -m 512M -nodefaults -nodefconfig -device virtio-serial-pci -serial 'mon:stdio' -bios OVMF.fd -pflash ovmf.var -net nic,model=virtio -net tap,fd=3 3<>/dev/tap11
