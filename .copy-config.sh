#!/usr/bin/env bash

dir=$HOME/documents/config

stuff="
     $HOME/.xbindkeysrc
     $HOME/.spacemacs
     $HOME/.saveme-spacemacs
     $HOME/.bashrc
     $HOME/.vimrc
     $HOME/bin/.setup_linux.sh
     $HOME/bin/.setup_linux.yaml
     $HOME/bin/.copy-config.sh
"
     # $HOME/.config/systemd/user/emacs.service
     # $HOME/.config/systemd/user/anamnesis.service
     
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
