#!/usr/bin/env bash
dir=$HOME/documents/config

stuff="
     $HOME/.xbindkeysrc
     $HOME/.spacemacs
     $HOME/.bashrc
     $HOME/.config/awesome/themes/zenburn/theme.lua
     $HOME/.config/awesome/rc.lua
     $HOME/documents/r/rprofile.site
     $HOME/bin/.configure_linux.sh
     $HOME/bin/.copy-config.sh
"


if [[ $1 == "out" ]];then
    cp $stuff $dir/
    echo commit like this:
    echo '    git commit --git-dir $HOME/documents/config -m "saving things" && git push origin master'
fi

if [[ $1 == "in" ]];then
    for s in $stuff; do
        cp $dir/`basename $s` `dirname $s`
    done
fi
