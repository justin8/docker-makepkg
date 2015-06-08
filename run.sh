#!/bin/bash
set -x
set -e

cp /src/* /build
chown -R nobody. /build
[[ $1 == update ]] && pacman -Syu || pacman -Sy

if [[ -n $@ ]]
then
	flags=$@
else
	flags='-fs --noconfirm'
fi
su nobody -s /bin/bash -c "makepkg $flags"
cp /build/*pkg.tar* /src
