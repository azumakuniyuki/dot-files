" $Id: dot.google-macvim-vimrc,v 1.7 2009/12/14 07:48:11 ak Exp $
" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc
"
" http://www.ibm.com/developerworks/jp/linux/library/l-vim-script-1/

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup    " do not keep a backup file, use versions instead
else
    set backup      " keep a backup file
endif

set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set cursorcolumn    " Highlight the screen column of the cursor(hl-CursorColumn)
set nocursorline    " Highlight the screen line of the cursor(hl-CursorLine)

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    augroup END

else
    " always set autoindenting on
    set autoindent

endif   " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

"-----------------------------------------------------------------------------
" The following lines copied from 'http://www.kawaz.jp/pukiwiki/?vim#hb6f6961'
"
if &encoding !=# 'utf-8'
    "set encoding=japan
    "set fileencoding=japan
    set encoding=utf-8
    set fileencoding=utf-8
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'

    " Can iconv reads 'eucJP-ms' text ?
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'

    " Can iconv reads 'JISX0213' text ?
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif

    " Set fileencodings
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif

    unlet s:enc_euc
    unlet s:enc_jis
endif

" Set 'fileencoding' = 'encoding' if there is no Japanese text.
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif

"-----------------------------------------------------------------------------
" Binary editor mode: vim -b or *.bin to boot
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

set tabstop=4
set softtabstop=4
set shiftwidth=4
set colorcolumn=80
" execute "set colorcolumn=" . join(range(81, 999), ',')

" set shiftround
set expandtab
set smartindent
set autoindent
set backspace=2     " 'Backspace' can delete indent and CR/LF
set wrapscan
set showmatch
set wildmenu        " See :help wildmenu
set formatoptions+=mM
let format_allow_over_tw=1


"---------------------------------------------------------------------------
set noignorecase
set smartcase
set noincsearch

set number
set ruler
set list
set listchars=tab:\|-,extends:<,eol:$
set wrap
set laststatus=2    " See :help laststatus
set cmdheight=2
set showcmd
set title

" set nobackup
set viminfo=
set noswapfile
set noundofile
set autoread
set backupdir=$HOME/var/spool/vim
set wildmode=longest,list,full

abbr RULER \|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|
abbr HLINE ----------------------------------------------------------------------------
abbr ULINE ____________________________________________________________________________
abbr ILINE ############################################################################
abbr SLINE ////////////////////////////////////////////////////////////////////////////
abbr PLINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
abbr 4LINE dnl ########################################################################

" map <F2> :r!date +\%F
" map <F2> a<C-R>=strftime("%F %T %z")<CR><Esc>
map  <F1> <ESC>
imap <F1> <ESC>
map  <F2> a<C-R>=strftime("%a, %e %b %Y %T %z (%Z)")<CR><Esc>
map  <F3> :r!cat ~/.myaddr

nnoremap j gj
nnoremap k gk
nnoremap / /\v
map <kPlus> <C-W>+
map <kMinus> <C-W>-
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" http://www.e2esound.com/wp/2010/11/07/add_vimrc_settings/
" imap {} {}<Left>
" imap [] []<Left>
" imap () ()<Left>
" imap <> <><Left>

" Do not load the following plug-ins.
let loaded_gzip = 0                 " plugin/gzip.vim
let loaded_getscriptPlugin = 0      " plugin/getScriptPlugin.vim
let loaded_matchparen = 0           " plugin/matchparen.vim
let loaded_netrwPlugin = 255        " plugin/netrwPlugin.vim
let loaded_rrhelper = 255           " plugin/rrhelper.vim
let loaded_spellfile_plugin = 255   " plugin/spellfile.vim
let loaded_tarPlugin = 255          " plugin/tarPlugin.vim
let TOhtml = 255                    " plugin/tohtml.vim
"let loaded_vimballPlugin = 0       " plugin/vimballPlugin.vim
let loaded_zipPlugin = 255          " plugin/zipPlugin.vim
" let loaded_lightline = 0          " plugin/lightline.vim

" lightline.vim
" https://github.com/itchyny/lightline.vim
let g:lightline = { 'colorscheme': 'wombat' }

let g:ruby_path = '' 

" Language libraries for Kaoriya
" See http://code.google.com/p/macvim-kaoriya/wiki/Readme
if has('kaoriya')
    let $PERL_DLL = ''
    let $PYTHON_DLL = ''
    let $RUBY_DLL = ''
endif
