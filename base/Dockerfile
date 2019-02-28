FROM gentoo/portage:latest as portage

FROM gentoo/stage3-amd64:latest

VOLUME /usr/portage

VOLUME /var/tmp/portage

VOLUME /var/tmp/ccache

VOLUME /var/lib/gentoo

ADD gentoo_keys.tar.xz .

COPY etc/portage /etc/portage

COPY --from=portage /usr/portage /usr/portage

RUN mkdir -p /var/lib/layman/

RUN touch /var/lib/layman/make.conf

RUN emerge ccache

RUN emerge portage

RUN emerge -e world
