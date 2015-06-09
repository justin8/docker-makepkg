#!/bin/bash
set -x
set -e

cp /src/* /build
chown -R nobody. /build
if [[ $1 == update ]]
then
	pacman -Syu
else
	pacman -Sy
	if [[ -n $@ ]]
	then
		flags=$@
	else
		flags='-fs --noconfirm'
	fi
fi

su nobody -s /bin/bash -c "makepkg $flags"
cp /build/*pkg.tar* /src
