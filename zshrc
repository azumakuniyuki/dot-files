# $Id: dot.zshrc,v 1.127 2009/09/18 06:48:57 ak Exp $
#            _              
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|
#                           
# ~/.zshrc                          (symbolic link)
# ~/etc/zshrc                       (this file)
# ~/etc/dot-files/dot.zsh-alias.*   (command aliases)
# ~/.ssh-agent                      (ssh-agent boot switch)
#
# As a login-shell
#   1. ~/.zshenv
#   2. ~/.zprofile
#   3. ~/.zshrc
#   4. ~/.zlogin
#
# As a interactive-shell
#   1. ~/.zshenv
#   2. ~/.zshrc
#
# As a command for executing shell script
#   1. ~/.zshenv
#
# When logout from zsh as a login shell
#   1. ~/.zlogout
#
################################################################################

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||S |||h |||e |||l |||l |||       |||V |||a |||r |||i |||a |||b |||l |||e |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
umask 022
limit coredumpsize 0
watch='all'

# Languages
shiftjis='ja_JP.SJIS'
eucjp='ja_JP.eucJP'
utf8jp='ja_JP.UTF-8'
ttyname=$(basename `tty`)

if [ -d "$HOME/etc" ]; then
    zshalias="$HOME/etc/zsh-alias.$OSTYPE"
    test -e $zshalias && source $zshalias
fi

#  ____ ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||C |||o |||m |||m |||a |||n |||d |||       |||P |||a |||t |||h ||
# ||__|||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
path=()
typeset -U path
dirs_in_usr=(bin sbin games ucb X11R6/bin)
dirs_in_home=(script bin sbin opt/bin opt/sbin)
dirs_in_local=(
    go teTeX ghostscript sendmail pgsql postgres postgresql mysql sqlite
    named apache httpd httpd2 uucp openssl clamXav clamav git subversion
    mercurial nginx MacGPG2 texlive
)

for x in $dirs_in_home; do
    test -d $HOME/$x && path=($path $HOME/$x)
done

for x in $dirs_in_local; do
    for y in bin sbin; do
        test -d /usr/local/$x/$y && path=($path /usr/local/$x/$y)
    done
done

for x in $dirs_in_usr; do
    for y in /usr/local /usr /opt/local /opt; do
        test -d $y/$x && path=($path $y/$x)
    done
    test -d /$x && path=($path /$x)
done
test -d $HOME/.go && path=($path $HOME/.go/bin)

#  ____ ____ ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||M |||a |||n |||p |||a |||g |||e |||s |||       |||P |||a |||t |||h ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
manpath=()
typeset -U manpath

for x in man share/man local/man local/share/man X11R6/man X11R6/share/man; do
    manpath=($manpath /usr/$x(N-/))
done

for x in $dirs_in_local; do
    manpath=($manpath /usr/local/$x/share/man(N-/))
    manpath=($manpath /usr/local/$x/man(N-/))
done

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||E |||n |||v |||. |||       |||V |||a |||r |||i |||a |||b |||l |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# vioptions='-U /dev/null -u /dev/null -c "set ai nu sm ts=8"'
if [ -x '/usr/bin/vi' ]; then
    export EDITOR='/usr/bin/vi'
    export VISUAL='/usr/bin/vi'

elif [ -x '/bin/vi' ]; then
    export EDITOR='/bin/vi'
    export VISUAL='/bin/vi'

else
    export EDITOR=vi
    export VISUAL=vi
fi

export EDITOR="$EDITOR $vioptions"
export VISUAL="$VISUAL $vioptions"
export GOHOME="$HOME/.go"

export DISPLAY='127.0.0.1:0.0'
export PAGER='less -r'
export TERM='xterm-256color'

export LANG=$utf8jp
export LC_MESSAGES=C
export LC_TIME=C
export LC_CTYPE=$utf8jp

REPORTTIME=3
WORDCHARS=${WORDCHARS:s,/,,}

if [ -e "$HOME/.cvsroot" ]; then
    export CVSROOT="`head -n 1 $HOME/.cvsroot`"
    export CVS_RSH='ssh'
    export CVSEDITOR="$EDITOR"
fi

test -f "$HOME/.email"  && export EMAIL="`cat $HOME/.email`"
test -x "`which rsync`" && export RSYNC_RSH='ssh'

if [ -z "$REMOTEHOST" ]; then
    if [ -n "$SSH_CLIENT" ]; then
        REMOTEHOST="`printenv SSH_CLIENT | awk '{print $1}'`"
    else
        REMOTEHOST='localhost'
    fi
fi

export GREP_OPTIONS='--binary-files=without-match'

#  ____ ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ 
# ||C |||o |||m |||m |||a |||n |||d |||       |||P |||r |||o |||m |||p |||t ||
# ||__|||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Bb    : bold
# C,c,. : `basename $cwd`
# D     : `date "+%d"`
# d     : `date "+%a"`
# h,!   : history number
# j     : The number of jobs
# l     : `basename `tty``
# M     : `hostname`
# m     : `hostname -s`
# n     : `logname`
# P     : `date '+%T`
# p     : `date '+%T%p`
# Ss    : turn over
# T     : HH:mm
# t,@   : HH:mm`date '+%p'`
# Uu    : underline
# W     : month number
# w     : month name(short)
# Y     : year number
# y     : year number(short)
# #     : # or >
# %     : %
# /,~   : $cwd
# ?     : $?
#
case ${UID} in
    0)
        PROMPT="%B%{[31m%}%/#%{[m%}%b "
        PROMPT2="%B%{[31m%}%_#%{[m%}%b "
        SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
        ;;
    *)
        PROMPT="%{%U%}%n@%m($ttyname):%{%B%}%c%{%b%}(%?)%{%u%} %# "
        PROMPT2=" %B(%_%) %b %% "
        SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
        RPROMPT="-[%j]"
        if [ -n "${REMOTEHOST}${SSH_CONNECTION}" -a $REMOTEHOST != 'localhost' ]; then
            PROMPT="${HOST%%.*} => ${PROMPT}"
        fi
    ;;
esac

setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt
unsetopt promptcr

#  ____ ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||o |||m |||m |||a |||n |||d |||       |||H |||i |||s |||t |||o |||r |||y ||
# ||__|||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
HISTFILE=~/.zhistory
HISTSIZE=131070
SAVEHIST=$HISTSIZE

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_expand
setopt hist_verify
setopt share_history
setopt extended_history

#  ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||z |||s |||h |||       |||C |||o |||m |||p |||l |||e |||m |||e |||n |||t ||
# ||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
autoload -U compinit && compinit

setopt magic_equal_subst
# setopt complete_in_word
# setopt glob_complete
# setopt mark_dirs

# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' use-cache yes
# zstyle ':completion:*' format '%B%d%b'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:default' list-colors ""
# zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _prefix
# zstyle ':completion:*' verbose yes

# _cache_hosts=()


#  ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||z |||s |||h |||       |||O |||p |||t |||i |||o |||n |||s ||
# ||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
bindkey -e
bindkey "^?" backward-delete-char

setopt auto_pushd
setopt long_list_jobs
setopt nobeep

chpwd_functions=($chpwd_functions dirs)

#  ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||z |||s |||h |||       |||A |||l |||i |||a |||s |||e |||s ||
# ||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#

alias j='jobs'
alias h='history 36'
alias up='cd ../;pwd'
alias today="date '+%F'"
alias vi="vi $vioptions"
alias rot13="tr '[a-zA-Z]' '[n-za-mN-ZA-M]'"

alias ls='/bin/ls -1F'
alias la='/bin/ls -laF'
alias ll='/bin/ls -Fla'
alias lc='/bin/ls -LCF'

if [ -x "`which ssh`" ]; then
    alias ssh='ssh -v42 -A'
    alias fwdssh='ssh -v42 -A -oStrictHostKeyChecking=no -oHashKnownHosts=no'
    alias fwdscp='scp -v42 -A -oStrictHostKeyChecking=no -oHashKnownHosts=no'
fi

if [ -x "`which sed`" ]; then
    alias comment-sharp="sed 's|^|# |g'"
    alias comment-slash="sed 's|^|// |g'"
    alias comment-semicolon="sed 's|^|; |g'"
    alias comment-lang-c="sed -e 's|^|/* |g' -e 's|$| */|g'"
fi

# HTTP User-Agent
ua_http01='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705; .NET CLR 1.1.4322)'
ua_http02='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)'
ua_http03='Opera/9.00 (Windows NT 5.1; U; en)'
ua_http04='Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.8)Gecko/20051130 Firefox/1.5'
ua_http05='Mozilla/5.0 (Windows; U; Windows NT 5.2; ja-JP;rv:1.7.12) Gecko/20050919 Firefox/1.0.7'
ua_http10='DoCoMo/2.0 P900iV(c100;TB;W24H11)'
ua_http11='Vodafone'
ua_http12='KDDI-KC32 UP.Browser/6.2.0.7.3.129 (GUI) MMP/2.0'

test -x "`which grep`"    && alias ip4grep="grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}'"
test -x "`which wget`"    && alias wget="wget -vnc -T32 -U '$ua_http05'"
test -x "`which curl`"    && alias curl="curl -LivfO# --connect-timeout 30 -A '$ua_http02'"
test -x "`which sqlite3`" && alias sqlite='sqlite3 -header -column'
test -x "`which ansible-playbook`" && alias ap='ansible-playbook'

if [ -x "`which git`" ]; then
    alias git-logx='git log --graph --decorate --pretty=format:"%ad [%cn] <c:%h t:%t p:%p> %n %Cgreen%d%Creset %s %n" --stat -p'
    alias git-arch='git archive'
    alias git-lsum='git log --stat --summary'
    alias git-stat='git status'
fi


#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||F |||u |||n |||c |||t |||i |||o |||n |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#

if [ -x "`which figlet`" ]; then
    alias figlet='figlet -w128'
    function fchar6 {
        echo $* | tr '[A-Za-z]' '[a-zA-Z]' | figlet -fcharact6 -w192
    }

    function fkbd {
        echo $* | figlet -fsmkeyboard -w192
    }
fi

function ip4rev {
    echo $* | sed 's/^\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)/\4.\3.\2.\1/g'
}

# Re: The removal of spaces after a tab-complete
# http://www.zsh.org/mla/users/2002/msg00798.html
function self-insert-no-autoremove {
    LBUFFER="$LBUFFER$KEYS"
}
zle -N self-insert-no-autoremove
bindkey '|' self-insert-no-autoremove


#  ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||s |||s |||h |||       |||a |||g |||e |||n |||t ||
# ||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
if [ -r "$HOME/.ssh-agent" ]; then

    ap=(`ps x | grep -i ssh-agent | grep -v 'grep'`)

    ## import running ssh-agent pid, socket
    if [ -n "$ap" ]; then
        SSH_AGENT_PID=$ap[1]
        SSH_AUTH_SOCK="`find /var/folders /tmp/ -user $USER -name 'agent.*' -type s 2> /dev/null | tr -s '/'`"
    else
        eval `ssh-agent` 2> /dev/null
        for v in `cat $HOME/.ssh-agent`; do
            ssh-add $v
        done
    fi
    unset ap
fi

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ 
# ||L |||o |||g |||i |||n |||       |||B |||a |||n |||n |||e |||r ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|
#
echo
echo "  * LOGNAME  : $USER ($UID:$GID)"
echo "  * FROM     : $REMOTEHOST"
echo "  * TO       : $HOST"
echo "  * TTY      : $TTY"
echo "  * DATE     : "`date "+%F(%a) %T" | tr "-" "/"`
echo "  * SYSTEM   : `uname -s -r` (`uname -m`)"
[ "$SSH_AUTH_SOCK" != "" ] && echo "  * AGENT    : $SSH_AUTH_SOCK"
echo '_______________________________________________________________'
echo

#  ____ ____ ____ ____ ____ _________ ____ ____ 
# ||C |||l |||e |||a |||n |||       |||U |||p ||
# ||__|||__|||__|||__|||__|||_______|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|
#
unset dirs_in_usr dirs_in_home dirs_in_local x y
unset vioptions ttyname

test -e "$HOME/.zshrc.local" && source $HOME/.zshrc.local

