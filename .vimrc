" 设置 leader 键为空格
let mapleader = " "

" 禁用 Vi 兼容模式，启用增强的 Vim 功能
set nocompatible

" 启用语法高亮。
syntax on

" 抑制启动消息。
set shortmess+=I

" 显示行号。
set number

" 显示相对行号，相对于当前行。
set relativenumber

" 始终显示状态栏。
set laststatus=2

" 使退格键行为更直观。
set backspace=indent,eol,start

" 允许隐藏有未保存更改的缓冲区。
set hidden

" 搜索默认不区分大小写。
" 如果搜索模式中包含大写字母，则搜索变为区分大小写。
set ignorecase
set smartcase

" 启用增量搜索，边输入边搜索。
set incsearch

" 禁用正常模式下的 'Q' 键（默认进入 Ex 模式）。
nmap Q <Nop> 

" 禁用响铃提示。
set noerrorbells visualbell t_vb=

" 启用鼠标支持。
set mouse+=a

" ctrlp插件
set runtimepath^=~/.vim/pack/vendor/start/ctrlp.vim

" Change the default mapping and the default command to invoke CtrlP:

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" When invoked, unless a starting directory is specified, CtrlP will set its local working directory according to this variable:

let g:ctrlp_working_path_mode = 'ra'

" 使用 vim-plug 来管理插件
" Begin the plugin section
call plug#begin()

" List the plugins you want to install
Plug 'preservim/NERDTree'         " NERDTree plugin
Plug 'wikitopian/hardmode'        " Hardmode plugin
Plug 'neomake/neomake'
" ... Add more plugins here ...

" End the plugin section
call plug#end()

" 自定义键映射:

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
