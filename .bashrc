###############################
# shell environment variables #
###############################

# locale
export LC_ALL="en_US.utf8"
# editor variable
export EDITOR="vim"
# visual variable
export VISUAL="vim"
# path variable
export PATH="$PATH:~/bin"
# disable history in less
export LESSHISTFILE="-"
# colorize manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# disable history
export HISTFILE=
# nntp server
export NNTPSERVER='news.otenet.gr'

#################
# shell options #
#################

# ignore small errors in cd
shopt -s cdspell
# check window size after each command
shopt -s checkwinsize
# save lines of a multiline command in same history entry
shopt -s cmdhist
# enable extended pattern matching features
shopt -s extglob
# case-insensitive filename globbing
shopt -s nocaseglob
# dont attempt to search PATH for completions
shopt -s no_empty_cmd_completion

##################
# shell settings #
##################

# dont overwrite existing files with redirection operators (>,>&,<>)
set -o noclobber

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
fi

# beautify the prompt
PS1="\[\e[0;36m\]\u@\h:\w\[\e[0;0m\]> "

# colors
if [ "$TERM" = "linux" ]; then
	echo -en "\e]P0000000" # black
	echo -en "\e]P8222222" # darkgrey
	echo -en "\e]P1bf7979" # darkred
	echo -en "\e]P9f4a45f" # red
	echo -en "\e]P297b26b" # darkgreen
	echo -en "\e]PAc5f779" # green
	echo -en "\e]P3cdcda1" # brown
	echo -en "\e]PBffffaf" # yellow
	echo -en "\e]P44a5463" # darkblue
	echo -en "\e]PC7d8794" # blue
	echo -en "\e]P59c3885" # darkmagenta
	echo -en "\e]PDe628ba" # magenta
	echo -en "\e]P688aadd" # darkcyan
	echo -en "\e]PE99ccff" # cyan
	echo -en "\e]P7d3d3d3" # lightgrey
	echo -en "\e]PFdedede" # white

	clear
fi

###########
# aliases #
###########

alias ls="ls --color=auto --group-directories-first -hF"
alias ll="ls --color=auto --group-directories-first -lA"
alias la="ls --color=auto --group-directories-first -A"
alias cd..="cd .."
alias df="df -h --print-type"
alias du="du -h --max-depth=1"
alias mem="free -m"
alias grep="grep -n --color=auto"
alias diff="colordiff"
alias mp="mplayer"
alias mc="mc -b"
alias cmplayer="mplayer -vo fbdev"
alias screendr="screen -D -R"
alias vi="vim"
alias netstatp="netstat -antuwp | egrep '(^[^t])|(^tcp.*LISTEN)'"
alias startx="startx -- -nolisten tcp"

#############
# functions #
#############

function mkcd() { mkdir "$1" && cd "$1"; }
function mktar() { tar czf "${1%%/}.tar.gz" "${1%%/}/"; }
#function blankfcd() { cdrecord -v dev=/dev/sr0 -blank=fast }
#function blankacd() { cdrecord -v dev=/dev/sr0 -blank=all }
#function burniso() { cdrecord -v dev=/dev/sr0 $1; }
#function scrot() { import -window root `date "+%Y-%m-%d--%H:%M:%S"`.png }
function burnndvd() { growisofs -Z /dev/sr0 -v -l -iso-level 3 -R -J -speed=2 $1; }
function burncdvd() { growisofs -M /dev/sr0 -v -l -iso-level 3 -R -J -speed=2 $1; }
# extract archives
function extrtar() {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1    ;;
             *.tar.gz)    tar xzf $1    ;;
             *.bz2)       bunzip2 $1    ;;
             *.rar)       unrar e $1    ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1     ;;
             *.tbz2)      tar xjf $1    ;;
             *.tgz)       tar xzf $1    ;;
             *.zip)       unzip $1      ;;
             *.Z)         uncompress $1 ;;
             *.7z)        7z x $1       ;;
             *)           echo "Error: $1 cannot be extracted" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
# compress archives
function comptar() {
     if [ $2 ]; then
         case $2 in
             tgz | tar.gz)   tar -zcvf$1.$2 $1 ;;
             tbz2 | tar.bz2) tar -jcvf$1.$2 $1 ;;
             tar.Z)          tar -Zcvf$1.$2 $1 ;;
             tar)            tar -cvf$1.$2  $1 ;;
             gz | gzip)      gzip           $1 ;;
             bz2 | bzip2)    bzip2          $1 ;;
             *)              echo   "Error: $2 cannot be compressed" ;;
         esac
     else
         compress $1 tar.gz
     fi
}
# view archive content
function viewtar() {
     if [[ -f $1 ]]; then
         case $1 in
             *.tar.gz)      gunzip -c $1 | tar -tvf - -- ;;
             *.tar)         tar -tvf $1 ;;
             *.tgz)         tar -ztvf $1 ;;
             *.zip)         unzip -l $1 ;;
             *.bz2)         tar -tvf $1 ;;
             *)             echo "$1 Error: cannot view $1 contents" ;;
         esac
     else
         echo "$1 is not a valid archive"
     fi
}
