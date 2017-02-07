# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
# *)
#     ;;
# esac

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

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -lh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# # Alias definitions.
# # You may want to put all your additions into a separate file like
# # ~/.bash_aliases, instead of adding them here directly.
# # See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# ETH mount
# mount -t cifs //nas-nethz-users.ethz.ch/share-o-$/oneyb /media/external/
export HOST=`uname -n`
export TERM=xterm-256color
export EDITOR='vi'
# Interesting:
# http://ciaran.compsoc.com/commands.html

# Arch wiki-search
alias aw='wiki-search'
alias awh='wiki-search-html'


### ----- App related stuff ----- ###
alias ask='ps aux | grep -i'
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update && sudo apt-get dist-upgrade'
alias agar='sudo apt-get autoremove'
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
function cbc()
{
    echo $* | cb
}
function Rinstall()
{
    Rscript -e "install.packages(\"$1\", INSTALL_opts=c(\"--html\", \"--latex\"), destdir=Rpkg.cache.dir)"
}

function get-bash-functions-for-bw2 ()
{
    source /d/documents/eaternity/eaternity/install-brightway-functions.bash
}

function turn-on-bw2-virtualenv ()
{
    dir=/d/documents/eaternity/bw2
    # if [ -z "$_OLD_VIRTUAL_PATH" ]; then
    if [ -n "which conda" ]; then
        echo activating
        # added by Miniconda3 4.2.12 installer
        export PATH="/d/documents/eaternity/bw2-py/bin:$PATH"
        source $dir/bin/activate
        PROMPT_COMMAND='echo -ne "\033]0;Brightway2\007"'
    else
        echo deactivating
        # added by Miniconda3 4.2.12 installer
        deactivate
        PROMPT_COMMAND='echo -ne "\033]0;Terminal\007"'
        export PATH=$(echo $PATH | sed -r 's/^[^:]+://g')
    fi
    # echo Restart emacs daemon?
    # xdotool type red
    # # Or
	  # if [[ -n "`pgrep -f emacs`" ]]; then
	  #     killall -w 'emacs'
	  # fi
	  # emacs --daemon
}

function backport_debian()
{
    # apt-get update
    mkdir -p $1-`date +%F`
    cd $1-`date +%F`
    sudo apt-get build-dep $1
    sudo apt-get -b source $1
    ls -l
    sudo dpkg -i *.deb
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

# R stuff
export R_PROFILE=~/documents/r/rprofile.site

# # # # # # # # # # # # # # # # # # # # # # #
# CSCS stuff
# File Server, Front-end
alias ela='ssh -YC oneyb@ela.cscs.ch'
# Cray XE6
alias rosa='ssh -YC oneyb@rosa.cscs.ch'
# Cray XE5
alias albis='ssh -YC oneyb@albis.cscs.ch'
# Cray XE5
alias lema='ssh -YC oneyb@lema.cscs.ch'
# pre and post processing cluster
alias ela-mount='sshfs oneyb@ela.cscs.ch:/ $HOME/cscs_mount'
# SB Cluster
alias pilatus='ssh -YC oneyb@pilatus.cscs.ch'
# # # # # # # # # # # # # # # # # # # # # # #


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

function red()
{
	  if [[ -n "`pgrep -f emacs`" ]]; then
	      killall -w 'emacs'
	  fi
	  emacs --daemon
}

function wget-R()
{
	  if [[ $# -eq 0 ]]; then
        echo usage: \n wget -R "comma-separate list of file suffixes" -m -p -E -k -K -np  -e robots=off "Website URL"
        exit 1
    fi
    wget -R $1 -m -p -E -k -K -np -e robots=off $2
}

function play-song()
{
    grep -iE "${1}[^/]*$" /d/music/playlists/all_music.m3u > /tmp/currentplaylist.m3u
    # find /d/music/$2 -type f -iname "*$1*" > /tmp/currentplaylist.m3u
    mplayer -playlist /tmp/currentplaylist.m3u
}

function song-find()
{
    grep -iE "${1}[^/]*$" /d/music/playlists/all_music.m3u
    # echo `find /D/Music/$2 -type f -iname "*$1*"`
}

### ----- Emacs stuff ----- ###
function E()
{
    if [[ $# -eq 0 ]]; then
	      sh -c "emacsclient -c" &
    else
	      sh -c "emacsclient -c $* " &
    fi
    #emacs -rv -fh --geometry 84x24+0+0 $1 &
}
function e()
{
    if [[ $# -eq 0 ]]; then
	      emacsclient -nw
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

function reduce-pix()
{
    if [[ $# -eq 0 ]]; then
	      q=96
    else
	      q=$1
    fi
    mkdir tmp && mv *JPG tmp/ && cd tmp/
    ls *JPG | while read pic; do
	      convert -quality $q $pic ../$pic;
    done
    if [[ $? -eq 0 ]]; then cd .. && rm -rf tmp/; fi
}

function youtube()
{
    youtube-dl -t --extract-audio --audio-format "best" -k $1
    rename 's/-[[:alnum:]_-]+\.mp/.mp/' *mp{3,4}
}

# if [ -d ~/Downloads ]; then rmdir ~/Downloads; fi

# get xbindkeys started
if [ "$PWD" == ~ ]; then pkill xbindkeys; xbindkeys; fi

if  [[ $- =~ .*i.* ]]; then  sh -c "~/bin/xb &"  ; fi

if [[ -n `pgrep -f 'emacs --smid'` ]]; then
    pkill -f 'emacs --smid'
fi

# # keyboard stuff
# setxkbmap -option "compose:caps"
# setxkbmap -option "caps:swapescape"
# setxkbmap -option "caps:escape"
set -o vi

xkbset exp 1 =sticky -twokey -latchlock

eval "$(pandoc --bash-completion)"
