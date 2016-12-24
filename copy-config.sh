#!/usr/bin/env bash
dir=$dir

if [[ $1 == "out" ]];then
    cp -r ~/.{spacemacs,bashrc,xbindkeysrc} $dir
    # # awesome stuff
    # cp -r ~/.config/awesom...  $dir
    cp -r ~/documents/r/rprofile.site $dir
    # # installation stuff
    # cp -r ~/bin/.config...  $dir
fi

if [[ $1 == "in" ]];then
    cp -r $dir/.{spacemacs,bashrc,xbindkeysrc} ~
    # # awesome stuff
    # cp -r ~/.config/awesom...  $dir
    cp -r $dir/rprofile.site ~/documents/r/
    # # installation stuff
    # cp -r ~/bin/.config...  $dir
fi

echo commit like this
echo 'git commit -m "saving things" && git push origin master'
