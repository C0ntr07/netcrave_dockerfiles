FROM ubuntu

RUN apt-get update

RUN apt-get -y install qemu-system-x86 curl wget ovmf file parted mtools

ADD https://cloudflare.cdn.openbsd.org/pub/OpenBSD/6.4/amd64/install64.fs /

RUN cp /usr/share/ovmf/OVMF.fd . 

RUN dd of=OVMF.vars bs=1k conv=notrunc if=OVMF.fd

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh
