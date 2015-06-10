##Docker makepkg##
[![Build Status](https://jenkins.dray.be/buildStatus/icon?job=docker_makepkg)](https://jenkins.dray.be/job/docker_makepkg)

This is a docker image for building Arch Linux packages in a clean container. New versions will be uploaded to the Docker registry the day after justin8/archlinux builds

#Usage#
The included dmakepkg script will wrap this image nicely and clean up after itself and is therefore the recommended way to use this docker image.
the final package file will be placed in the current directory when run with dmakepkg and can be used as a drop in replacement for local makepkg.

The default flags sent to makepkg is `--force --syncdeps --noconfirm`
Both the dmakepkg and running the image directly support overriding default flags. Any additional flags at the end will be passed directly to makepkg instead of the ones outlined above.
It is also possible to pass the word `update` as the only argument (others after are ignored in this case). This will run a pacman -Syu before building the package. Useful if you haven't updated the master image yet but need to build against the latest libraries.

The image can  also be run manually. You need to bind the source directory with a PKGBUILD to /src (e.g. `-v $(pwd):/src` to mount current directory). The final package file will be placed in the bound directory.
