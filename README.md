# Docker makepkg

This is a docker image for building Arch Linux packages in a clean container.

## Release schedule
New versions will be uploaded to the Docker registry the day after justin8/archlinux builds. Usually the second of each month. No tagged releases will be made. Only latest as is usual for Arch dev tools.


## Usage
The included dmakepkg script will wrap this image nicely and clean up after itself and is therefore the recommended way to use this docker image.
the final package file will be placed in the current directory when run with dmakepkg and can be used as a drop in replacement for local makepkg.

The default flags sent to makepkg is `--force --syncdeps --noconfirm`
Both the dmakepkg and running the image directly support overriding default flags. Any additional flags at the end will be passed directly to makepkg instead of the ones outlined above.
Passing '-p' will run a pacman -Syu before building the package. Useful if you haven't updated the master image yet but need to build against the latest libraries.
Passing '-u' will let you specify a UID to chown the file to before outputting it again. '-g' will let you also set the group (but requires -u as well or it will be ignored'
All remaining parameters will be passed directly through to makepkg.

The image can  also be run manually. You need to bind the source directory with a PKGBUILD to /src (e.g. `-v $(pwd):/src` to mount current directory). The final package file will be placed in the bound directory, no other files will be modified
