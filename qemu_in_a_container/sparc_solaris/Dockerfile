FROM ubuntu

RUN apt-get update

RUN apt-get -y update

RUN apt-get -y install qemu-system-sparc openbios-sparc

COPY vm.ini /vm.ini

COPY solaris_2.6_598_sparc.iso /solaris_2.6_598_sparc.iso

COPY ss20_v2.25_rom /ss20_v2.25_rom

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh
