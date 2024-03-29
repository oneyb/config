#nmcli connection modify myvpnconnectionname +vpn.data username y~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


export HOST=`uname -n`
export TERM=xterm-256color
# export EDITOR='vi'
export ALTERNATE_EDITOR=vim EDITOR=emacsclient VISUAL=emacsclient
export BROWSER="exo-open"

# Arch wiki-search
alias aw='wiki-search'
alias awh='wiki-search-html'


### ----- App related stuff ----- ###
alias l='ls -hl --color'
alias lt='ls -lht --color'
alias ll='ls -Alh --color'
alias ask='ps aux | grep -i'
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update && sudo apt-get upgrade'
alias agdu='sudo apt-get update && sudo apt-get dist-upgrade'
alias agsaptitude='sudo aptitude search'
alias ags='apt-cache search'
alias agar='sudo apt-get autoremove'
alias cman='man 3'
# alias agi='sudo apt-get install'
# alias agr='sudo apt-get remove'
# alias agu='sudo apt-get update && sudo apt-get dist-upgrade'
# alias ags='apt-cache search'
# alias agar='sudo apt-get autoremove'

# # cool redirection example
# # begin example
# cat > something.sh << end_input
# #!/bin/bash
# echo $HOST
# echo 'Hello World!'
# end_input
# # end example and run
# bash end_input

# Functions
function o()
{
    if [[ $# -eq 1 ]] ; then
	      if [[ -e $1 ]] ; then
	          nohup xdg-open "$1" > /dev/null 2>&1 &
	      else
	          for o in `ls $*`; do
		            nohup xdg-open "$o" > /dev/null 2>&1 &
	          done
	      fi
    else
	      for o in $*; do
	          nohup xdg-open "$o" > /dev/null 2>&1 &
	      done
    fi
}

function begin-working-on-py2module()
{
    venv=$1
    if [ ! -d ~/venvs/$venv ]; then
        virtualenv -p python2 ~/venvs/$venv
        source ~/venvs/$venv/bin/activate
        pip2 install -r ~/github/$venv/requirements.txt
        # pip3 install Ipython
        if [ $? -eq 0 ]; then
            cd ~/github/$venv/
            git status
        else
            \rm -rf ~/venvs/$venv
            echo 'Fix something please'
        fi
    else 
        source ~/venvs/$venv/bin/activate
        cd ~/github/$venv/
        git status
    fi
}

function begin-working-on-py3module-gh()
{
    venv=$1
    if [ ! -d ~/venvs/$venv ]; then
        virtualenv -p python3 ~/venvs/$venv
        source ~/venvs/$venv/bin/activate
        pip3 install -r ~/github/$venv/requirements.txt
        pip3 install Ipython
        if [ $? -eq 0 ]; then
            cd ~/github/$venv/
            git status
        else
            \rm -rf ~/venvs/$venv
            echo 'Fix something please'
        fi
    else 
        source ~/venvs/$venv/bin/activate
        cd ~/github/$venv/
        git status
    fi
}
function begin-working-on-py3module-gl()
{
    venv=$1
    if [ ! -d ~/venvs/$venv ]; then
        virtualenv -p python3 ~/venvs/$venv
        source ~/venvs/$venv/bin/activate
        pip3 install -r ~/gitlab/$venv/requirements.txt
        pip3 install Ipython
        if [ $? -eq 0 ]; then
            cd ~/gitlab/$venv/
            git status
        else
            \rm -rf ~/venvs/$venv
            echo 'Fix something please'
        fi
    else 
        source ~/venvs/$venv/bin/activate
        cd ~/gitlab/$venv/
        git status
    fi
}

function begin-working-on-website()
{
    venv=$1
    if [ ! -d ~/venvs/$venv ]; then
        virtualenv ~/venvs/$venv
        source ~/venvs/$venv/bin/activate
        pip install -r ~/github/$venv/requirements.txt
        if [ $? -eq 0 ]; then
            cd ~/github/$venv/
            git status
            xdotool type 'python app.py'
        else
            \rm -rf ~/venvs/$venv
            echo 'Fix something please'
        fi
    else 
        source ~/venvs/$venv/bin/activate
        cd ~/github/$venv/
        git status
        xdotool type 'python app.py'
    fi
}

function begin-working-oneyb-website()
{
    begin-working-on-website oneyb.github.io
}

function begin-working-baerfutt-website()
{
    begin-working-on-website baerfutt.github.io
}

function begin-working-maildog()
{
    begin-working-on-py3module maildog
}

function begin-working-app()
{
    cd ~/Sync/flutter/flutter_lkjh; flutter run
}

function begin-learning-embedded()
{
    cd ~/Sync/embedded-programming
    o  
}

function check-setpath()
{
    pres=$(echo $PATH | grep texlive)
    if [[ -z $pres ]]; then
	    if [ -d "$HOME/bin" ] ; then
	        export PATH="$HOME/bin:$PATH"
	    fi
	    
	    if [ -d /usr/local/src/texlive/ ]; then
	        export PATH="/usr/local/src/texlive/bin/$(uname -m)-$(uname -s | sed 's/.*/\L&/'):$PATH" 
	    fi
	    
	    if [ -d /usr/local/arduino ]; then
	        export PATH="/usr/local/arduino:$PATH" 
	    fi

        # anamnesis --restart
        # xb
    fi
}

function sortgmail ()
{
    source ~/venvs/sortgmail/bin/activate
    python ~/gitlab/sortgmail/sortgmail.py
    deactivate
}

function clean-lit()
{
    rmspace
    rename -v 's/[-_]?\(.*\)[-_]?//' *
    # rename -v 's/\[[a-zA-Z-_]+\][-_]?//' *
    # rename -v 's/[\[\]]//g' *
    ls *pdf | while read p; do 
        pdf-shrink ${p} ${p}.pdf
    done
    ls *epub | while read e; do 
        ebook-convert $e ${e/%.epub/.EPUB}
        if [ $? -eq 0 ]; then
            rm $e
        fi
    done
}

function video-shrink ()
{
    for i in $*; do ffmpeg -i $i -vf scale=iw/3:-1 -r 30 shrunk_${i}; done
}

function describe-funs ()
{
    type $*
}
_describe-funs_completion()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(sed -r '/[a-zA-Z_i]+ ? \( ?\)/!d;s/^f?u?n?c?t?i?o?n ?([a-zA-Z_-]+) ? \(?\).*$/\1/' ~/.bashrc)" -- $cur) )
}
complete -F _describe-funs_completion funs

function explore-gsettings ()
{
    gsettings list-schemas | grep "$1" | while read f; do gsettings list-recursively $f | grep "$2"; done
}
_ems_completion()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(gsettings list-schemas)" -- $cur) )
}
complete -F _ems_completion explore-gsettings

function cbc()
{
    echo $* | cb
}

function stman-addid-to-remote-machine ()
{
    STID=$(stman device info $USER | sed -r '/ID:/!d;s/^.*: +([[:alnum:]-]+)/\1/')
    ssh $remote stman device add $STID
}

function clean-phone () {
    adb shell rm /storage/6FAA-E43C/DCIM/Camera/*
}
# function organize-udacity () {
#     adb shell mv /storage/6FAA-E43C/Android/data/com.udacity.android/files/udacity-downloads/* \
#         /sdcard/Android/data/com.udacity.android/files/udacity-downloads/
# }
# function get-bash-functions-for-bw2 ()
# {
#     source $HOME/documents/eaternity/eaternity/eaternity-brightway-functions.bash
# }

function convert-notebooks ()
{
    if [ $# -eq 0 ]; then
        format=html
    else
        format=$1
    fi
    mkdir -p $format
    for ipynb in *ipynb; do
        jupyter nbconvert --to $format --output-dir=$format/ $ipynb
    done
}


function backport_debian()
{
    # from debian wiki

    # apt-get update
    mkdir -p $1-`date +%F`
    cd $1-`date +%F`
    sudo apt-get build-dep $1
    sudo apt-get -b source $1
    sudo dpkg -i *.deb
}

function update-boxes ()
{
    ~/bin/.copy-config.sh out
    cd $HOME/documents/config
    git commit . -m 'gitting things together' && git push origin master
    cd -
    if [[ $(hostname) == 'tinkbox.local' ]]; then
        goal=oney@oney.local
    else
        goal=oney@tinkbox.local
    fi
    ssh $goal ~/bin/.copy-config.sh in 
}

function wait-on-process-then ()
{
    if [[ $# -eq 0 ]]; then
        type wait-on-process-then;
    else 
        while [[ -n $(pgrep -f $1) ]]; do echo waiting on $1; sleep 10; done
        ${@:2}
    fi
}
# wait-on-process-then firefox echo craap

function concatenate-media ()
{
    ffmpeg -f concat -safe 0 -i <(for f in ${@:2}; do echo "file '$PWD/$f'"; done) -c copy ${1}
}


function concatenate-media-elegant ()
{
    dir=dvd-copy-work
    mv *mp4 $dir
    cd $dir
    rmspace
    rename -v 's/-/-0/' *-{1..9}.*
    concatenate-media $1 *
    [ $? == 0 ] && mv $1 ../copied/ && trash-put * && cd ..
}

# cool function name
function gitty-up () {
    git commit -a -m "$*" && git push origin master
}

sync-machines () {
    box=oney@tinkbox.local
    rsync -vurt --delete .profile $box:/home/oney/
    rsync -vurt --delete $HOME/literature/ $box:/home/oney/literature/
    rsync -vurt --delete $HOME/documents/ $box:/home/oney/documents/
    rsync -vurt --delete $HOME/github/ $box:/home/oney/github/
    rsync -vurt --delete $HOME/gebastel/ $box:/home/oney/gebastel/
}

push-pio-dev () {
    box=pi@raspberrypi.local
    rsync -vurt $HOME/gebastel/ $box:/home/pi/gebastel/ 
    box=pi@hassbian.local
    rsync -vurt $HOME/gebastel/rpi-ap-ha/homeassistant/ $box:/home/homeassistant/.homeassistant/ 
}
push-pio-dev-del () {
    box=pi@raspberrypi.local
    rsync -vurt --delete $HOME/gebastel/ $box:/home/pi/gebastel/ 
    box=pi@hassbian.local
    rsync -vurt --delete $HOME/gebastel/rpi-ap-ha/homeassistant/ $box:/home/homeassistant/.homeassistant/ 
}

pull-pio-dev-del () {
    box=pi@raspberrypi.local
    rsync -vurt --delete $box:/home/pi/gebastel/ $HOME/gebastel/
    box=pi@hassbian.local
    rsync -vurt --delete $box:/home/homeassistant/.homeassistant/ $HOME/gebastel/rpi-ap-ha/homeassistant/
}
pull-pio-dev () {
    box=pi@raspberrypi.local
   rsync -vurt $box:/home/pi/gebastel/ $HOME/gebastel/
   box=pi@hassbian.local
   rsync -vurt $box:/home/homeassistant/.homeassistant/ $HOME/gebastel/rpi-ap-ha/homeassistant/
}
function saveme-spacemacs ()
{
    emacs -Q -l $HOME/.saveme-spacemacs $* &
}
function saveme-spacemacsn ()
{
    emacs -nw -Q -l $HOME/.saveme-spacemacs $* &
}

function merge-dotspacemacs ()
{
    # cd ~/github/config; git pull; cd -
    emacsclient -c -e '(ediff-files (expand-file-name "~/.spacemacs") (expand-file-name "~/work-exchange/config/.spacemacs"))'
}
function merge-dotspacemacs-saveme ()
{
    # cd ~/github/config; git pull; cd -
    emacsclient -c -e '(ediff-files (expand-file-name "~/.saveme-spacemacs") (expand-file-name "~/work-exchange/config/.saveme-spacemacs"))'
}


# tex to docx
# htlatex test.tex "xhtml,ooffice" "ooffice/! -cmozhtf" "-cooxtpipes -coo"
#   pandoc sig-alternate.tex                \
    #     --from=latex                       \
    #     --to=docx                          \
    #     --biblatex                         \
    #     --bibliography sigproc.bib         \
    #     --output=sig-alternate.docx        \
    #     --reference-docx=my-reference.docx

# Keyboard shortcuts
# https://github.com/kermit666/dotfiles/tree/master/autokey

# R & Python stuff
export R_PROFILE=$HOME/documents/config/rprofile.site
# export WORKON_HOME=$HOME/.virtualenvs
export WORKON_HOME=$HOME/venvs

### ----- Random Documentation stuff ----- ###
function bulgarian ()
{
    name=$HOME/literature/languages/bulgarian/intensive-bulgarian-1/`printf %.2d $1`.-track-$1.flac
    mpv $name
}

function spanish ()
{
    name=$HOME/literature/languages/spanish/caminos-plus-2-cd-zum-arbeitsbuch/`printf %.2d $1`-track-$1.mp3
    mpv $name
}
alias schwiizertuetsch='o $HOME/literature/languages/german/misc/schwyzertüütsch-praktische-sprachlehre-des-schweizerdeutschen.pdf'

# # Image processing tricks
# montage *.png -title "\n Lägern-Hochwacht\n" -crop +0+96 -mode concatenate -tile x4 Lae-3d-TS.png
# mencoder mf://*10-50_main_CO2_*.png -mf w=800:h=600:fps=3:type=png -ovc copy -oac copy -o CO2_D2_A_E_10-50.avi

### ----- Presentation stuff ----- ###
## Impressive presentation
alias impress='impressive --nologo -c memory -L time=BL --fontsize 16'

# nook stuff - be sure to have the adbWireless on nook running
alias Nook='adb connect 192.168.0.102'
alias Nook='adb connect 192.168.0.102'

### ----- File management ----- ###
alias du='du -hs'
alias rm='trash-put'
alias rmold='rm *~ .*~'
alias rmlatex='\rm *aux *log *out *synctex.gz *fdb_latexmk *fls *bbl'
alias sti='xkbset exp 1 sticky -twokey -latchlock'

function red()
{
    # bash -c 'systemctl --user restart emacs' &
    if [[ -n "`pgrep -f emacs`" ]]; then
	        killall -w 'emacs'
	    fi
    cd ~
	  emacs --daemon
    cd -
}

function wget-R()
{
	  if [[ $# -ne 2 ]]; then
        echo usage: \n wget -R -A "comma-separate list of file suffixes" -m -p -E -k -K -np  -e robots=off "Website URL" exit 1
    fi
    wget -R -A $1 -m -p -E -k -K -np -e robots=off $2
}

function play-song()
{
    grep -iE "${1}[^/]*$" ~/music/playlists/all_music.m3u > /tmp/currentplaylist.m3u
    # find $HOME/music/$2 -type f -iname "*$1*" > /tmp/currentplaylist.m3u
    mpv --shuffle --audio-display=no --playlist=/tmp/currentplaylist.m3u
}

function play()
{
    mpv ${@:1:$(($#-1))} --audio-display=no --playlist=$HOME/music/playlists/${@:$#} 
    [ $? -ne 0 ] && echo -e "\n\t usage example:\t play --shuffle albums/tool/lateralus.m3u "
}
_play_completion()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(find $HOME/music/playlists/ -type f -name '*m3u' | sed -r 's:'"$HOME"'/music/playlists/::')" -- $cur) )
    # COMPREPLY=( $(compgen -W "$(ls $HOME/music/playlists/)" -- $cur) )
}
complete -F _play_completion play

function openvpn-add-udp()
{
    nmcli connection import type openvpn file $HOME/.vpn/ovpn_udp/$1
    nmcli connection modify ${1%.ovpn} +vpn.data username=zenlines@gmail.com
}
_openvpn-add-udp()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(basename -a $(find $HOME/.vpn/ovpn_udp/ -type f -name '*ovpn'))" -- $cur) )
}
complete -F _openvpn-add-udp openvpn-add-udp 

function openvpn-add-tcp()
{
    nmcli connection import type openvpn file $HOME/.vpn/ovpn_tcp/$1
    nmcli connection modify ${1%.ovpn} +vpn.data username=zenlines@gmail.com
}
_openvpn-add-tcp()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(basename -a $(find $HOME/.vpn/ovpn_tcp/ -type f -name '*ovpn'))" -- $cur) )
}
complete -F _openvpn-add-tcp openvpn-add-tcp 

function connect-openvpn()
{
    nmcli connection up $1
}
_connect-openvpn()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(nmcli connection show | sed -r '/\bvpn\b/!d;s:^([^ ]+).*$:\1:')" -- $cur) )
}
complete -F _connect-openvpn connect-openvpn

function find-song()
{
    grep -iE "${1}[^/]*$" $HOME/music/playlists/all_music.m3u
    # echo `find $HOME/Music/$2 -type f -iname "*$1*"`
}

### ----- Emacs stuff ----- ###
function E()
{
    if [[ $# -eq 0 ]]; then
	      sh -c "emacsclient -c --eval '(org-tags-view t \"computer\")'" -a gvim &
    else
	      sh -c "emacsclient -c $* " -a gvim &
    fi
    #emacs -rv -fh --geometry 84x24+0+0 $1 &
}
function e()
{
    if [[ $# -eq 0 ]]; then
	      emacsclient -nw --eval '(org-tags-view t "computer") -a gvim'
 
    else
	      emacsclient -nw "$*" -a gvim
    fi
}

# if [[ -n `which pandoc` ]]; then
#     eval "$(pandoc --bash-completion)"
# fi

# R easy for the command line
function Rex()
{
    Rscript -e "$*"
}

function install_manual_deb ()
{
    wget $1
    sudo dpkg -i `basename $1`
    if [ $# -eq 0 ]; then
        sudo apt-get install -f
    fi
    mv `basename $1` $HOME/bin/src/
}

function ebook-convert-to-pdf()
{
    b=${2:-${1%.*}}.pdf
    ebook-convert $1 $b                                       \
                  --margin-top=69                             \
                  --margin-left=69                            \
                  --margin-right=69                           \
                  --margin-bottom=69                          \
                  --pdf-page-numbers
}


function spellcheck()
{
    reps=`grep -En '(\<.*\>[[:blank:]]+)\1' $1`
    splitis=`grep -En 'to\ [A-Za-z]+ly' $1`
    if [[ -z $reps ]]; then echo "No repeated words in $1";
    else
	      echo "Repeated words:"
	      echo "$reps"
    fi
    if [[ -z $splitis ]]; then echo "No split infinitives in $1";
    else
	      echo "Split infinitives:"
	      echo "$splitis"
    fi
}

function Telephone()
{
    grep -il $1 ~/documents/crap/contacts/phone-numbers/* | while read file;
    do cat ${file} | sed -r '/VCARD/d' \
	          | sed -r 's/^.*:|=|2\.1//g' | sed -r 's/;/\ /g'
    done
}


function convert-mts()
{
    mkdir -p mp4
    ls *MTS | while read mp; do
	      # echo converting ./$mp to mp4/${mp/.MTS}.mp4
 	      avconv -y -threads 2 -i ./$mp -c:a copy -c:v copy mp4/${mp/.MTS}.mp4
    done
}

function convert-flac()
{
    cd ~/music
    ls | while read dir; do
	      echo Converting flacs in $dir
	      flac2all_v3.38.py mp3 ./$dir/ -o ./$dir/mp3-copies
    done
    find -type d -empty -delete
}

function pdf-shrink ()
{
    if [ $# -eq 0 ]; then
        echo usage: $0 input_pdf [output_pdf]
    elif [ $# -eq 1 ]; then
        opdf=${1/%.pdf/-compress.pdf}
    elif [ "$2" == "$1" ]; then
        opdf=$1
    else
        opdf=$2
    fi
    tpdf=$(tempfile)
    tpdf2=$(tempfile)
    pdftk "$1" cat output "$tpdf"
    # mutool clean "$1" "$tpdf"
    if [ $? -eq 0 ]; then
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
           -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages \
           -dCompressFonts=true -r150 -sOutputFile="$tpdf2" "$tpdf"
        if [ $? -eq 0 ]; then
            mv "$tpdf2" "$opdf" && echo great success
            \rm $tpdf 
        else
            mv "$tpdf" "$opdf" && echo less great success
            \rm $tpdf2
        fi
    fi
}

function pdf-shrink-rasterize () {
    if [ $# -eq 0 ]; then
        echo usage $0 input_pdf [output_pdf]
    elif [ $# -eq 1 ]; then
        opdf=${1/.pdf/-compress.pdf}
    else
        opdf=$2
    fi
    tmp=$(tempfile)
    pdftocairo -jpeg $1 $tmp
    convert $tmp*jpg $opdf
}

function gear-list-sync ()
{
    cp Sync/backpacking/gear-list.xlsx                        Sync/backpacking/gear-list_bu.xlsx
    cp -u work-exchange/cdt/gear-list.xlsx                   Sync/backpacking/gear-list.xlsx
    cp -u Sync/backpacking/gear-list.xlsx                   work-exchange/cdt/gear-list.xlsx 
    cp Sync/backpacking/ski-traverse-planning.xlsx         Sync/backpacking/ski-traverse-planning_bu.xlsx
    cp -u Sync/backpacking/ski-traverse-planning.xlsx         work-exchange/cdt/ski-traverse-planning.xlsx 
    cp -u work-exchange/cdt/ski-traverse-planning.xlsx         Sync/backpacking/ski-traverse-planning.xlsx
}


function pix-org()
{
    cd ~/pictures/$(date +%Y)/tmp
    rmspace
    mkdir -p raw && mv *jpg raw/ 
    if [[ $? -eq 0 ]]; then 
        cd raw/
        ls *jpg | while read pic; do
	          convert -quality 96 $pic ../$pic;
        done
        if [[ $? -eq 0 ]]; then cd .. && rm -rf raw/; fi
    fi
    cd ~/pictures/$(date +%Y)/tmp
    exiftool -r -d %Y%m%d_/%Y%m%d_%H%M%S%%-c '-FileName<${datetimeoriginal}_${model;}.%e' .
    exiftool -r -d %Y%m%d_/%Y%m%d_%H%M%S%%-c '-FileName<${createdate}.%e' -ext mp4 .
    rmspace
    mv *_/ ..
}

function pix-reduce()
{
    _DIR=$PWD
    if [[ $# -eq 0 ]]; then
	      q=96
    else
	      q=$1
    fi
    exiftool '-FileName<${CreateDate}_${model;}.%e' -d '%Y%m%d_%H%M%S%%-c' .
    rmspace
    mkdir -p tmp && mv *jpg tmp/ 
    if [[ $? -eq 0 ]]; then 
        cd tmp/
        ls *jpg | while read pic; do
	          convert -quality $q $pic ../$pic;
        done
        if [[ $? -eq 0 ]]; then cd .. && rm -rf tmp/; fi
    fi
    cd $_DIR
}


function apply--preset-to-pic()
{
    pix=$* 
    PATH=$PATH:$HOME/bin/src/fmwconcepts
    ls ~/bin/src/fmwconcepts/ | while read s; do
        mkdir -p $s;
        for f in $pix; do
            $s $f $s/$f;
        done;
    done
}

function apply-edgefx-bw-pictures()
{
    PATH=$PATH:$HOME/bin/src/fmwconcepts
    mkdir -p $0
    for f in $*; do
        edgefx $f $0/$f;
        localthresh $0/$f $0/$f;
    done
}

function apply-funny-effect-to-pix()
{
    pix=$* 
    scripts='
      edgefx
      feather
      furrowed
      lichtenstein
      localthresh
      lucisarteffect
      sketch
      sketching
      tintilize
      toon
      vintage1
      vintage3
    '
    PATH=$PATH:$HOME/bin/src/fmwconcepts
    for s in $scripts; do
        mkdir -p $s;
        for f in $pix; do
            [[ ! -f $s/$f ]] && $s $f $s/$f;
        done;
    done
}

function paperpix-to-pdf ()
{
    PATH=$PATH:$HOME/bin/src/fmwconcepts
    for f in $*; do
        textdeskew $f /tmp/${f}
        textcleaner /tmp/${f} /tmp/${f}
        whiteboard /tmp/${f} ${f%.*}-paper.${f##*.}.pdf
    done
}



function go-fish-pictures()
{
    pix=$* 
    scripts='
      adaptivegamma
      autolevel
      autotone
      autotone2
      balance
      bcimage
      binomial
      cartoon
      color2gray
      colortoning
      crossprocess
      dualtonemap
      duotonemap
      edgefx
      emboss
      enhancelab
      enrich
      feather
      furrowed
      gradient
      graytoning
      isolatecolor
      lichtenstein
      localthresh
      lucisarteffect
      painteffect
      peelingpaint
      remap
      removecolorcast
      shadowhighlight
      sharpedge
      sketch
      sketcher
      sketching
      smartcrop
      splittone2
      splittone3
      tintilize
      toon
      toonify
      vintage1
      woodcut
    '
    PATH=$PATH:$HOME/bin/src/fmwconcepts
    for s in $scripts; do
        mkdir -p $s;
        # for f in $pix; do $s $f $s/$f; done;
        for f in $pix; do
            $s $f $s/$f;
        done;
    done
}

function youtube-dl-music()
{
    # youtube-dl --extract-audio --audio-format "best" -k $1 --exec "'rename \"s/-[[:alnum:]_-]+\.([[:alnum:]]+$)/$1/\" {}'" --cache-dir ~/youtube-dl/ $*
    youtube-dl --extract-audio --audio-format "best" -k $1 --cache-dir ~/youtube-dl/ --restrict-filenames $*
}


# ex - archive extractor
# usage: ex <file>
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.xz)    tar xJf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
compress ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar cjf $*   ;;
            *.tar.xz)    tar cJf $*   ;;
            *.tar.gz)    tar xzf $*   ;;
            *.bz2)       bunzip2 $*   ;;
            *.rar)       unrar x $*   ;;
            *.gz)        gunzip $*    ;;
            *.tar)       tar xf $*    ;;
            *.tbz2)      tar xjf $*   ;;
            *.tgz)       tar xzf $*   ;;
            *.zip)       unzip $*     ;;
            *.Z)         uncompress $*;;
            *.7z)        7z c $*      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# if [ -d ~/Downloads ]; then rmdir ~/Downloads; fi

# get xbindkeys started
if [ "$PWD" == ~ ]; then 
    bash -c 'pkill xbindkeys && xbindkeys' &> /dev/null
fi

if  [[ $- =~ .*i.* ]]; then  sh -c "~/bin/xb &"  ; fi

if [[ -n `pgrep -f 'emacs --smid'` ]]; then
    pkill -f 'emacs --smid'
fi

if [ $USER = "pi" ]; then
	  # keyboard stuff
	  setxkbmap -option "caps:escape,compose:102"
	  xkbset exp 1 =sticky -twokey -latchlock
fi

if [ "$(ls -1 /dev/disk/by-uuid | sed '1!d')" = "23e07b94-b859-4ead-914c-a8f763120cea" ];
then
	  # keyboard stuff
	  xkbset exp 1 =sticky -twokey -latchlock
    setxkbmap -option 'compose:prsc,caps:escape'
fi

set -o vi
bind -m vi-insert "\C-l":clear-screen

anamnesis --restart &> /dev/null
# git clone -l --no-hardlinks ~/Sync/org /stuff/academic-archive/org
if [ -d /stuff/academic-archive/org/ ]; then
    rsync -urt ~/Sync/org/ /stuff/academic-archive/org/
fi
rsync -a --cvs-exclude --delete --exclude=".gitignore" --exclude=".stfolder" --exclude="org-archive" ~/org/ ~/Sync/org/
bash -c 'cd ~/Sync/org/; git commit . -m "$(date +%F-%R) saving org stuff progress"' &> /dev/null
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# lineageos stuff
export USE_CCACHE=1
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx13G"
# add Android SDK platform tools to path
if [ -d "$HOME/android/platform-tools" ] ; then
    PATH="$HOME/android/platform-tools:$PATH"
fi
function update-nordvpn-server-config ()
{
    cd ~/.vpn
    [ -f nord-ovpn.zip ] && mv nord-ovpn.zip nord-ovpn-old-$(date +%F).zip
    [ -d ovpn_tcp ] && mv "ovpn_tcp" "ovpn_tcp_old-$(date +%F)"
    [ -d ovpn_udp ] && mv "ovpn_udp" "ovpn_udp_old-$(date +%F)"
    curl -o nord-ovpn.zip https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
    unzip nord-ovpn.zip
}

source ~/.private

eval "$(starship init bash)"
