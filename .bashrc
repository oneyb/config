#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	  local fgc bgc vals seq0

	  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	  # foreground colors
	  for fgc in {30..37}; do
		    # background colors
		    for bgc in {40..47}; do
			      fgc=${fgc#37} # white
			      bgc=${bgc#40} # black

			      vals="${fgc:+$fgc;}${bgc}"
			      vals=${vals%%;}

			      seq0="${vals:+\e[${vals}m}"
			      printf "  %-9s" "${seq0:-(default)}"
			      printf " ${seq0}TEXT\e[m"
			      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		    done
		    echo; echo
	  done
}

# [[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
#
# ~/.extend.bashrc
#

# Change the window title of X terminals
case ${TERM} in
	  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		    ;;
	  screen*)
		    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		    ;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	  && type -P dircolors >/dev/null \
	  && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	  if type -P dircolors >/dev/null ; then
		    if [[ -f ~/.dir_colors ]] ; then
			      eval $(dircolors -b ~/.dir_colors)
		    elif [[ -f /etc/DIR_COLORS ]] ; then
			      eval $(dircolors -b /etc/DIR_COLORS)
		    fi
	  fi

	  if [[ ${EUID} == 0 ]] ; then
		    PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	  else
		    PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	  fi

	  alias ls='ls --color=auto'
	  alias grep='grep --colour=auto'
	  alias egrep='egrep --colour=auto'
	  alias fgrep='fgrep --colour=auto'
else
	  if [[ ${EUID} == 0 ]] ; then
		    # show root@ when we don't have colors
		    PS1='\u@\h \W \$ '
	  else
		    PS1='\u@\h \w \$ '
	  fi
fi

unset use_color safe_term match_lhs sh

alias free='free -m'                      # show sizes in MB
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
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

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

export HOST=`uname -n`
export TERM=xterm-256color
# export EDITOR='vi'
export ALTERNATE_EDITOR=vim EDITOR=emacsclient VISUAL=emacsclient
export BROWSER="exo-open"

# Arch wiki-search
alias aw='awman'
alias awh='wiki-search-html'

### ----- App related stuff ----- ###
alias ask='ps aux | grep -i'
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update && sudo apt-get upgrade'
alias agdu='sudo apt-get update && sudo apt-get dist-upgrade'
alias agsaptitude='sudo aptitude search'
alias ags='sudo apt-cache search'
alias agar='sudo apt-get autoremove'
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


function clean-lit()
{
    ls *pdf | while read p; do 
        pdftk $p cat output ${p/.pdf/.PDF}
        if [ $? -eq 0 ]; then
            rm $p
        fi
    done
    ls *epub | while read e; do 
        ebook-convert $e ${e/.epub/.EPUB}
        if [ $? -eq 0 ]; then
            rm $e
        fi
    done
    rename -v 's/[-_]?\(.*\)[-_]?//' *
    rename -v 's/\[[a-zA-Z-_]+\][-_]?//' *
    rename -v 's/[\[\]]//g' *
    rmspace
}

function cbc()
{
    echo $* | cb
}

function get-bash-functions-for-bw2 ()
{
    source /d/documents/eaternity/eaternity/eaternity-brightway-functions.bash
}

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
    # apt-get update
    mkdir -p $1-`date +%F`
    cd $1-`date +%F`
    sudo apt-get build-dep $1
    sudo apt-get -b source $1
    ls -l
    sudo dpkg -i *.deb
}


# cool function name
function gitty-up () {
    git commit -a -m "$*" && git push origin master
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
export R_PROFILE=$HOME/r/rprofile.site
export WORKON_HOME=$HOME/.virtualenvs

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
alias sti='xkbset exp 1 sticky -twokey -latchlock'

function red()
{
    bash -c 'systemctl --user restart emacs' &
    # if [[ -n "`pgrep -f emacs`" ]]; then
	  #       killall -w 'emacs'
	  #   fi
	  #   emacs --daemon
}

function wget-R()
{
	  if [[ $# -eq 0 ]]; then
        echo usage: \n wget -R "comma-separate list of file suffixes" -m -p -E -k -K -np  -e robots=off "Website URL"
        exit 1
    fi
    wget -R $1 -m -p -E -k -K -np -e robots=off $2
}

function song-play()
{
    grep -iE "${1}[^/]*$" /d/music/playlists/all_music.m3u > /tmp/currentplaylist.m3u
    # find /d/music/$2 -type f -iname "*$1*" > /tmp/currentplaylist.m3u
    mplayer -playlist /tmp/currentplaylist.m3u
}

function play()
{
    mplayer -playlist /d/music/playlists/$1
}

_play()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(find /d/music/playlists/ -type f -name '*m3u' | sed -r 's:/d/music/playlists/::')" -- $cur) )
    # COMPREPLY=( $(compgen -W "$(ls /d/music/playlists/)" -- $cur) )
}
complete -F _play play

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
    ebook-convert $1 $2                             \
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
        echo usage $0 input_pdf [output_pdf]
    elif [ $# -eq 1 ]; then
        opdf=${1/.pdf/-compress.pdf}
    else
        opdf=$2
    fi
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
       -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages \
       -dCompressFonts=true -r150 -sOutputFile=$opdf $1
}


function reduce-pix()
{
    if [[ $# -eq 0 ]]; then
	      q=96
    else
	      q=$1
    fi
    rmspace
    mkdir tmp && mv *jpg tmp/ && cd tmp/
    ls *jpg | while read pic; do
	      convert -quality $q $pic ../$pic;
    done
    if [[ $? -eq 0 ]]; then cd .. && rm -rf tmp/; fi
}

function youtube()
{
    youtube-dl --extract-audio --audio-format "best" -k $1
    rename 's/-[[:alnum:]_-]+\.([[:alnum:]]+$)/$1/' *mp{3,4} *mkv *m4a
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

