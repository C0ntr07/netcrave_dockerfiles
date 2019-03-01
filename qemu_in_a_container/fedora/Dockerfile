FROM ubuntu

RUN apt-get update

RUN apt-get -y install qemu-system-x86 curl wget ovmf 

ADD "https://boot.alpinelinux.org/alpine-ipxe/x86_64/ipxe.efi" /

ADD https://dl.fedoraproject.org/pub/fedora/linux/releases/29/Workstation/x86_64/os/isolinux/vmlinuz /

ADD https://dl.fedoraproject.org/pub/fedora/linux/releases/29/Workstation/x86_64/os/isolinux/initrd.img /

RUN cp /usr/share/ovmf/OVMF.fd . 

RUN dd of=OVMF.vars bs=1k conv=notrunc if=OVMF.fd

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh
