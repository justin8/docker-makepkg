#!/bin/bash
usage() {
	cat <<-EOF
	usage: $(basename "$0") [OPTIONS] [makepkg parameters]

	This wrapper for makepkg will default to running with '--force --syncdeps --noconfirm'.
	Any unrecognized parameters will be passed directly through to makepkg.

	OPTIONS:
	-h	Display this help
	-p	Run a pacman -Syu before building
	-u	UID to own any created package
	-g	GID to own any created package (Ignored unless UID is also provided)
	EOF
}

while getopts ":g:hpu:" OPTION
do
	case $OPTION in
		g)
			group=$OPTARG
			;;
		h)
			usage
			exit 0
			;;
		p)
			update=true
			;;
		u)
			user="$OPTARG"
			;;
	esac
done
shift $(( OPTIND -1 ))

if ! [[ -f /src/PKGBUILD ]]
then
	echo "No PKGBUILD file found! Aborting."
	exit 1
fi

# cp errors if there is a directory, even though we don't want to copy directories
cp /src/* /build
set -e
chown -R build-user. /build
if [[ -n $update ]]
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

su build-user -s /bin/bash -c "makepkg $flags"

if [[ -n $user ]]
then
	chown="$user"
	if [[ -n $group ]]
	then
		chown="${chown}:${group}"
	fi
	chown -R $chown /build
fi

# Don't fail if there is no pkg but custom flags were specified. i.e. -cors will only test, but not create a package
cp /build/*pkg.tar* /src &>/dev/null || [[ -n $@ ]]
