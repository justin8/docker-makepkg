#!/bin/bash
set -x

cp /src/* /build
chown -R nobody. /build
[[ $1 == update ]] && pacman -Syu || pacman -Sy

su nobody -s /bin/bash -c "makepkg -fs --noconfirm"
cp /build/*pkg.tar* /src
