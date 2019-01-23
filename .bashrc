# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# [ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=200000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color) color_prompt=yes;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
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
alias l='ls -l --color'
alias lt='ls -lt --color'
alias ll='ls -Al --color'
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

function begin-working-on-py3module()
{
    venv=$1
    if [ ! -d ~/venvs/$venv ]; then
        virtualenv -p python3 ~/venvs/$venv
        source ~/venvs/$venv/bin/activate
        pip3 install -r ~/github/$venv/requirements.txt
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
function begin-working-on-pymodule()
{
    venv=$1
    if [ ! -d ~/venvs/$venv ]; then
        virtualenv ~/venvs/$venv
        source ~/venvs/$venv/bin/activate
        pip install -r ~/github/$venv/requirements.txt
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
    begin-working-on-pymodule maildog
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

function clean-lit()
{
    rmspace
    rename -v 's/[-_]?\(.*\)[-_]?//' *
    # rename -v 's/\[[a-zA-Z-_]+\][-_]?//' *
    # rename -v 's/[\[\]]//g' *
    tmp=$(tempfile)
    ls *pdf | while read p; do 
        pdf-shrink ${p} ${p}
    done
    ls *epub | while read e; do 
        ebook-convert $e ${e/%.epub/.EPUB}
        if [ $? -eq 0 ]; then
            rm $e
        fi
    done
}

function video-shrink () {
    for i in $*; do ffmpeg -i $i -vf scale=iw/2:-1 shrunk_${i}; done
}


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
#     source /d/documents/eaternity/eaternity/eaternity-brightway-functions.bash
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
        while [[ -n $(pgrep $1) ]]; do echo waiting on $1; sleep 10; done
        ${@:2}
    fi
}
# wait-on-process-then firefox echo craap

function concatenate-media ()

{
    ffmpeg -f concat -safe 0 -i <(for f in $*; do echo "file '$PWD/$f'"; done) -c copy concatenated-${1}
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
export WORKON_HOME=$HOME/.virtualenvs

### ----- Random Documentation stuff ----- ###
function bulgarian ()
{
    name=/d/literature/languages/bulgarian/intensive-bulgarian-1/`printf %.2d $1`.-track-$1.flac
    mplayer $name
}

function spanish ()
{
    name=/d/literature/languages/spanish/caminos-plus-2-cd-zum-arbeitsbuch/`printf %.2d $1`-track-$1.mp3
    mplayer $name
}
alias schwiizertuetsch='o /d/literature/languages/german/misc/schwyzertüütsch-praktische-sprachlehre-des-schweizerdeutschen.pdf'

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
	    emacs --daemon
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
    grep -iE "${1}[^/]*$" /d/music/playlists/all_music.m3u > /tmp/currentplaylist.m3u
    # find /d/music/$2 -type f -iname "*$1*" > /tmp/currentplaylist.m3u
    mplayer --shuffle --audio-display=no -playlist /tmp/currentplaylist.m3u
}

function play()
{
    mplayer --shuffle --audio-display=no -playlist /d/music/playlists/$1
}

_play_completion()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(find /d/music/playlists/ -type f -name '*m3u' | sed -r 's:/d/music/playlists/::')" -- $cur) )
    # COMPREPLY=( $(compgen -W "$(ls /d/music/playlists/)" -- $cur) )
}
complete -F _play_completion play

function find-song()
{
    grep -iE "${1}[^/]*$" /d/music/playlists/all_music.m3u
    # echo `find /D/Music/$2 -type f -iname "*$1*"`
}

### ----- Emacs stuff ----- ###
function E()
{
    if [[ $# -eq 0 ]]; then
	      sh -c "emacsclient -c --eval '(org-tags-view t \"computer\")'" &
    else
	      sh -c "emacsclient -c $* " &
    fi
    #emacs -rv -fh --geometry 84x24+0+0 $1 &
}
function e()
{
    if [[ $# -eq 0 ]]; then
	      emacsclient -nw --eval '(org-tags-view t "computer")'
 
    else
	      emacsclient -nw "$*"
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
    pdftk "$1" cat output "$tpdf"
    # mutool clean "$1" "$tpdf"
    if [ $? -eq 0 ]; then
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
           -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages \
           -dCompressFonts=true -r150 -sOutputFile="$opdf" "$tpdf"
        \rm $tpdf
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


function reduce-pix()
{
    _DIR=$PWD
    if [[ $# -eq 0 ]]; then
	      q=96
    else
	      q=$1
    fi
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

function organize-photos (){
    reduce-pix
    exiftool '-FileName<CreateDate' -d %Y%m%d_%H%M%S%%-c.%%e *jpg
    # ls | sed -r 's/^([0-9]+)_.*$/\1/' | uniq | while read d; do mkdir -p $(date -d $d +%F); mv $d* $(date -d $d +%F); done
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

