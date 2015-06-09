This is a docker image for building Arch Linux packages in a clean container

Bind a location with a PKGBUILD to /src and it will output the package. passing 'update' to it will run a pacman -Syu beforehand for building C and other projects that depend on upstream libraries that can change. Or if you want to run some options other than -rs --noconfirm, you can specify them in-place of 'update' as the parameters. All specified parameters (other than update as the first parameter) will be passed directly to makepkg.
