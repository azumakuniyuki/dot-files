" $Id: dot.google-macvim-gvimrc,v 1.1 2009/07/23 00:05:02 ak Exp $
" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2001 Sep 02
"
" To use it, copy it to
"  for Unix and OS/2:   ~/.gvimrc
"  for Amiga:           s:.gvimrc
"  for MS-DOS and Win32:$VIM\_gvimrc
"  for OpenVMS:         sys$login:.gvimrc
"--------------------------------------------------------------------------------------------------
set mousehide   " Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>


" Font Configurations
"--------------------------------------------------------------------------------------------------
" set guifont=M+2VM+IPAG\ circle\ Regular:h12.5
" set guifontwide=M+2VM+IPAG\ circle\ Regular:h12.5
" set guifont=Migu\ 2M\ Regular:h14
" set guifont=Envy\ Code\ R:h13.5
" set guifont=Mensch:h13
" set guifont=Fira\ Code:h13
" set guifont=Cascadia\ Code:h13.5
" set guifont=Source\ Han\ Code\ JP\ R:h14
" set guifont=Myna:h15
set guifont=0xProto:h15
set linespace=2

" Window Configurations
"--------------------------------------------------------------------------------------------------
" set columns=158 lines=49 cmdheight=1  " XGA 1024x768 Screen(iBookG4)
" set columns=188 lines=56 cmdheight=1  " 1440x960 Screen(PowerBookG4)
" set columns=144 lines=55 cmdheight=1  " 1710x1112(MacBook Air)
set columns=144 lines=64  " 3008x1692 (DELL U2723QE)

" Color & Highlight
"--------------------------------------------------------------------------------------------------
hi CursorIM  guifg=black  guibg=red  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse

augroup ZenkakuSpaceGroup
    autocmd!
    autocmd BufNewFile,BufRead * match ZenkakuSpace / /
augroup END
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#e2041b

color michitsuna

