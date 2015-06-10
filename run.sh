#!/bin/bash
set -x

# cp errors if there is a directory, even though we don't want to copy directories
cp /src/* /build
set -e
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
		flags='--force --syncdeps --noconfirm'
	fi
fi

su nobody -s /bin/bash -c "makepkg $flags"
cp /build/*pkg.tar* /src
