#!/usr/bin/env bash

dir=$HOME/documents/config

stuff="
     $HOME/.xbindkeysrc
     $HOME/.spacemacs
     $HOME/.bashrc
     $HOME/.vimrc
     $HOME/.config/awesome/rc.lua
     $HOME/.config/i3/config
     $HOME/r/rprofile.site
     $HOME/.config/systemd/user/emacs.service
     $HOME/.config/systemd/user/anamnesis.service
     $HOME/bin/.setup_linux.sh
     $HOME/bin/.copy-config.sh
"

if [[ $1 == "out" ]];then
    cp -a $stuff $dir/
    echo commit like this:
    echo "  cd $dir;  git commit . -m 'saving things' && git push origin master; cd -"
fi

if [[ $1 == "in" ]];then
    cd $dir;  git pull
    for s in $stuff; do
        cp -a $(basename $s) $(dirname $s)
    done
    cd -
fi
