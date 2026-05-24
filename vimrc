" $Id: dot.google-macvim-vimrc,v 1.7 2009/12/14 07:48:11 ak Exp $
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
if v:progname =~? "evim" | finish | endif
if has("vms")
    set nobackup    " do not keep a backup file, use versions instead
else
    set backup      " keep a backup file
endif

"--------------------------------------------------------------------------------------------------
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,sjis,iso-2022-jp
set fileformats=unix,dos,mac

set autoread
set backspace=2     " 1:indent,eol, 2:indent,eol,start(allow backspacing over everything in insert mode)
set history=512     " keep 500 lines of command line history
set wildmenu        " See :help wildmenu
set wildmode=longest,list,full

set relativenumber
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set title
set colorcolumn=100
set laststatus=2    " See :help laststatus
set listchars=tab:\|-,extends:<,eol:$
set cmdheight=2
set list
set wrap
set wrapscan

set hlsearch
set incsearch       " do incremental searching
set noignorecase
set cursorcolumn    " Highlight the screen column of the cursor(hl-CursorColumn)
set nocursorline    " Highlight the screen line of the cursor(hl-CursorLine)
set belloff=all     " Be quiet
set smartcase

set showmatch
set formatoptions+=mM
let format_allow_over_tw=1

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set noswapfile
set noundofile
set backupdir=$HOME/var/spool/vim

"--------------------------------------------------------------------------------------------------
if exists('&ambiwidth') | set ambiwidth=single | endif
if has('mouse') | set mouse=a | endif " In many terminal emulators the mouse works just fine, thus enable it.

" Mapping & Abbreviations
"--------------------------------------------------------------------------------------------------
" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo, so that you can undo CTRL-U
" after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

map  <F1> <ESC>
imap <F1> <ESC>
map  <F2> a<C-R>=strftime("%a, %e %b %Y %T %z (%Z)")<CR><Esc>

imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap <> <><Left>

nnoremap j gj
nnoremap k gk
nnoremap / /\v
map <kPlus> <C-W>+
map <kMinus> <C-W>-
nmap <ESC><ESC> :nohlsearch<CR><ESC>

abbr RULER \|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|----\|
abbr HLINE ---------------------------------------------------------------------------------------------------
abbr ULINE ___________________________________________________________________________________________________
abbr ILINE ###################################################################################################
abbr SLINE ///////////////////////////////////////////////////////////////////////////////////////////////////
abbr PLINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
abbr 4LINE dnl ###############################################################################################

" Autocmd & Filetype
"--------------------------------------------------------------------------------------------------
if has("autocmd")
    " Only do this part when compiled with support for autocommands.
    " - Enable file type detection.
    " - Use the default filetype settings, so that mail gets 'tw' set to 72, 'cindent' is on in C files, etc.
    " - Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    augroup vimrcEx
        " Put these in an autocmd group, so that we can delete them easily.
        au!
        autocmd FileType text setlocal textwidth=99 " For all text files set 'textwidth' to 99 characters.

        " When editing a file, always jump to the last known cursor position. Don't do it when the
        " position is invalid or when inside an event handler (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default position when opening a file.
        autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END

    augroup BinaryXXD
        " Binary editor mode: vim -b or *.bin to boot
        autocmd!
        autocmd BufReadPre  *.bin let &binary =1
        autocmd BufReadPost * if &binary | silent %!xxd -g 1
        autocmd BufReadPost * set ft=xxd | endif
        autocmd BufWritePre * if &binary | %!xxd -r | endif
        autocmd BufWritePost * if &binary | silent %!xxd -g 1
        autocmd BufWritePost * set nomod | endif
    augroup END
endif

if !exists(":DiffOrig")
    " Convenient command to see the difference between the current buffer and the file it was loaded
    " from, thus the changes you made.  Only define it when not defined already.
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" Plugins
"--------------------------------------------------------------------------------------------------
" The following plugins are disabled because I do not use these.
let g:loaded_getscriptPlugin    = 1 " Vim script updater
let g:loaded_gzip               = 1
let g:loaded_logiPat            = 1
let g:loaded_manpager           = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_rrhelper           = 1 " vim-R helper
let g:loaded_spellfile_plugin   = 1 " spell checker
let g:loaded_tarPlugin          = 1
let g:loaded_tohtml             = 1
let g:loaded_tutor              = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_zipPlugin          = 1

" Indent Guides(https://github.com/nathanaelkane/vim-indent-guides)
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 4
let g:indent_guides_tab_guides = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

let g:vimsyn_embed              = ''
let g:markdown_fenced_languages = ['go', 'perl', 'ruby', 'sh']

" https://github.com/vim-airline/vim-airline
let s:airline_themes0 = ['base16_gruvbox_light_hard', 'base16_mocha', 'blood_red', 'fruit_punch', 'qwq', 'sierra']
let s:random_seed    = reltime()[1]
let s:theme_index    = s:random_seed % len(s:airline_themes0)
let g:airline_theme  = s:airline_themes0[s:theme_index]
let g:airline#extensions#tabline#enabled = 1

