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

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2            " Make command line two lines high
set mousehide       " Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500
    " I like highlighting strings inside C comments
    let c_comment_strings=1

    " Switch on syntax highlighting if it wasn't on yet.
    if !exists("syntax_on")
        syntax on
    endif

    " Switch on search pattern highlighting.
    set hlsearch

    " For Win32 version, have "K" lookup the keyword in a help file
    "if has("win32")
    "  let winhelpfile='windows.hlp'
    "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
    "endif

    " Set nice colors
    " background for normal text is light grey
    " Text below the last line is darker grey
    " Cursor is green, Cyan when ":lmap" mappings are active
    " Constants are not underlined but have a slightly lighter background
    "highlight Normal guibg=grey90
    "highlight Cursor guibg=Green guifg=NONE
    "highlight lCursor guibg=Cyan guifg=NONE
    "highlight NonText guibg=grey80
    "highlight Constant gui=NONE guibg=grey95
    "highlight Special gui=NONE guibg=grey95
endif

if exists("c_comment_strings")
    unlet c_comment_strings
endif

"---------------------------------------------------------------------------
" Font Configurations
" set guifont=M+2VM+IPAG\ circle\ Regular:h12.5
" set guifontwide=M+2VM+IPAG\ circle\ Regular:h12.5
" set guifont=Migu\ 2M\ Regular:h14
" set guifont=Envy\ Code\ R:h13.5
set guifont=Mensch:h13
" set macligatures
" set guifont=Fira\ Code:h13
set linespace=1


"---------------------------------------------------------------------------
" IME Configurations
" inoremap <ESC> <ESC>:set iminsert=0<CR>
" if has('gui_macvim')
"   set imdisable
" endif

"---------------------------------------------------------------------------
" Window Configurations
"
" XGA 1024x768 Screen(iBookG4)
" set columns=158   " Width
" set lines=49      " Height
" set cmdheight=1   " Command line at bottom of window

" 1440x960 Screen(PowerBookG4)
" set columns=188   " Width
" set lines=56      " Height
" set cmdheight=1   " Command line at bottom of window
" set statusline=\ \ \ \ %<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 1440x900(MacBook Air)
set columns=155     " Width
set lines=44        " Height
set cmdheight=1     " Command line at bottom of window

" http://opentechpress.jp/developer/07/11/06/0151231.shtml
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
" set statusline=\ \ \ \ %F%m%r%h%w\ [%{&fenc}.%{&ff}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" http://www.e2esound.com/wp/2010/11/07/add_vimrc_settings/
hi CursorIM  guifg=black  guibg=red  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse

" Hilight current line
"  set cursorline
"  augroup cch
"    autocmd! cch
"    autocmd WinLeave * set nocursorline
"    autocmd WinEnter,BufRead * set cursorline
"  augroup END

" color nebuchadnezzar
" color heiankyo
" color russian-blue
" color mikeneko
color shironeko
" color sabineko

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#e2041b
au BufNewFile,BufRead * match ZenkakuSpace /　/

