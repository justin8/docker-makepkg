FROM justin8/archlinux
MAINTAINER justin@dray.be

RUN mkdir -p /build
WORKDIR /build
RUN pacman -Syuq --noconfirm --needed base-devel && rm -rf /var/cache/pacman/pkg/*
ADD sudoers /etc/sudoers
ADD run.sh /run.sh

VOLUME "/src"

ENTRYPOINT ["/run.sh"]
