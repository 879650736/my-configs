let mapleader = " "
" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a


set runtimepath^=~/.vim/pack/vendor/start/ctrlp.vim

" Change the default mapping and the default command to invoke CtrlP:

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" When invoked, unless a starting directory is specified, CtrlP will set its local working directory according to this variable:

let g:ctrlp_working_path_mode = 'ra'

 " Begin the plugin section
call plug#begin()

" List the plugins you want to install
Plug 'preservim/NERDTree'         " NERDTree plugin
Plug 'wikitopian/hardmode'        " Hardmode plugin
Plug 'neomake/neomake'
" ... Add more plugins here ...

" End the plugin section
call plug#end()

" Optionally, you can add additional configuration for your plugins here

nnoremap <leader>w :wq<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-z> u
nnoremap <C-a> ggVG
nnoremap <C-s> :w<CR>a

inoremap <C-a> <Esc>ggVG
inoremap <C-z> <Esc>u
inoremap <C-s> <Esc>:w<CR>a

" 垂直拆分窗口
nnoremap <leader>\ :vsplit<CR>

" 水平拆分窗口
nnoremap <leader>- :split<CR>

" 窗口间切换
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" 启用 undofile 以保存撤销历史
set undofile

" 配置 undodir 以指定撤销历史文件的存储位置
set undodir=~/.vim/undo

" 确保 undo 目录的权限合适
if has('persistent_undo')
    set undodir=~/.vim/undo
endif

" 使用语法折叠方法
set foldmethod=syntax

" 启动时不展开折叠
set nofoldenable

" 折叠列宽为2
set foldcolumn=2

" 打开文件时自动折叠所有内容
autocmd BufReadPost,FileReadPost * normal zM
