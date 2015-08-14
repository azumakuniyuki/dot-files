# $Id: dot.zshenv,v 1.127 2009/09/18 06:48:57 ak Exp $
#            _                     
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V / 
# (_)___|___/_| |_|\___|_| |_|\_/  
#                                  
################################################################################
path=(~/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin)

if [ -x "`which uname`" ]; then
	case "`uname -sr`" in
		FreeBSD*); export OSTYPE='freebsd' ;;
		Linux*);   export OSTYPE='linux'   ;;
		CYGWIN*);  export OSTYPE='cygwin'  ;;
		IRIX*);    export OSTYPE='irix'    ;;
		OSF1*);    export OSTYPE='osf1'    ;;
		Darwin*);  export OSTYPE='darwin'  ;;
		*);        export OSTYPEI="dummy"  ;;
	esac
else
	export OSTYPE='dummy'
fi

export LANG=C
export LC_MESSAGES=C
export LC_TIME=C
export LC_CTYPE=C

export BLOCKSIZE='1k'
export PERL_BADLANG=0
export FTPMODE='passive'

export EDITOR='vi'
export VISUAL='vi'

