FROM justin8/archlinux
MAINTAINER justin@dray.be

RUN mkdir -p /build
WORKDIR /build
RUN pacman -Syuq --noconfirm --needed base-devel && rm -rf /var/cache/pacman/pkg/*
RUN pacman -Syuq --noconfirm --needed git mercurial bzr subversion openssh && rm -rf /var/cache/pacman/pkg/*
RUN useradd -d /build build-user
ADD sudoers /etc/sudoers
ADD run.sh /run.sh

VOLUME "/src"

ENTRYPOINT ["/run.sh"]
