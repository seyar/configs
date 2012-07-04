#!/bin/sh
# Config builder
# Copyright 2012 Alexander Tarmolov <tarmolov@gmail.com>
# TODO: --ignore submodules for git-status (git 1.7.2)
# TODO: Include for gitcongig (git 1.7.10)
# TODO: autoupdate config every day/week/month
# TODO: notify if name and e-mail aren't set

# show program usage
show_usage() {
    echo "usage: ./build.sh [--clean] --name=<your name> --email=<your email> [--yandexemail=<your yandex email>]"
    echo "      --clean         removes all builded files (optional)"
    echo "      --name          your name for git and debian"
    echo "      --email         your email for git and debian"
    echo "      --yandexemail   your email at Yandex Company for git and debian (optional)"
    exit
}

# show usage if '--help' is the first argument or no argument is given
case $1 in
    ""|"--help") show_usage ;;
esac

# process command-line arguments
for OPT in "$@" ; do
    case $OPT in
        -*)  true ;
            case $OPT in
               --clean)
                    read -p "Do you want to delete .bashrc, .profile, .gitconfig, .screenrc, .vimrc and .vim? (y/n)? "
                    [ "$REPLY" != "y" ] ||
                        for file in .bashrc .profile .gitconfig .screenrc .vimrc .vim
                            do
                                rm -rf ~/$file
                            done
                    exit;;
                --name=*)
                    NAME=${OPT##*=}
                    echo $NAME
                    shift ;;
                --email=*)
                    EMAIL=${OPT##*=}
                    echo $EMAIL
                    shift ;;
                --yandexemail=*)
                    YANDEX_EMAIL=${OPT##*=}
                    shift ;;
                -*)
                    echo "Illegal option"
                ;;
            esac
        ;;
    esac
done

ln -sf .configs/.screenrc ~
ln -sf .configs/.gitconfig ~
ln -sf .configs/.vim ~
ln -sf .configs/.vimrc ~
git submodule init
git submodule update
vim -c ":BundleInstall" -c ":qa"

# generate .profile if name and e-mail are set
if [ -n "$NAME" ] &&  [ -n "$EMAIL" ]; then
    rm -rf ~/.profile
    echo "export DEBFULLNAME=\"$NAME\"\nexport DEBEMAIL=$EMAIL\nexport EMAIL=$EMAIL\n. ~/.configs/.profile" > ~/.profile
else
    ln -sf .configs/.profile ~
fi

# screen doesn't read .profile
ln -sf ~/.profile ~/.bashrc
