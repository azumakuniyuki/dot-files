#!/bin/sh
# $Id: dot.xinitrc,v 1.1 2009/07/23 00:05:02 ak Exp $

X11ROOT="/usr/X11R6"

# Read the .Xresources
if [ -f "${HOME}/.Xresources" ]; then
	${X11ROOT}/bin/xrdb -merge ${HOME}/.Xresources
fi

# Start some nice programs
# 1) kterm || xterm
#	-jis-fixed-medium-*-*-*-*-*-*-*-*-*-jisx0208.1983-*
if [ -x "${X11ROOT}/bin/kterm" ]; then
	kterm -geometry 169x54+128+128 -b 4 -st -sb -sl 8192 -km euc &
else
	xterm -geometry 169x54+22+64 -bg white -fg darkblue -b 4 -st -sb -sl 8192 &
fi

# start the window manager
exec ${X11ROOT}/bin/quartz-wm
