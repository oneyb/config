#!/usr/bin/env bash

dir=$HOME/documents/config

stuff="
     $HOME/.xbindkeysrc
     $HOME/.spacemacs
     $HOME/.bashrc
     $HOME/.vimrc
     $HOME/.config/awesome/themes/zenburn/theme.lua
     $HOME/.config/awesome/rc.lua
     $HOME/r/rprofile.site
     $HOME/bin/.setup_linux.sh
     $HOME/bin/.copy-config.sh
"

if [[ $1 == "out" ]];then
    cp $stuff $dir/
    echo commit like this:
    echo "  cd $dir;  git commit . -m 'saving things' && git push origin master; cd -"
fi

if [[ $1 == "in" ]];then
    cd $dir;  git pull
    for s in $stuff; do
        cp $(basename $s) $(dirname $s)
    done
    cd -
fi
