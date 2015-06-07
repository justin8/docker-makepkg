This is a docker image for building Arch Linux packages in a clean container

Bind a location with a PKGBUILD to /src and it will output the package. passing 'update' to it will run a pacman -Syu beforehand for building C and other projects that depend on upstream libraries that can change.
