set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'jez/vim-superman'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"

Plugin 'vim-airline/vim-airline'

" Git wrapper, to integrate also with airline
Plugin 'tpope/vim-fugitive'

" Show git hunks
Plugin 'airblade/vim-gitgutter'




" Vundle examples ... only github probably matters ...

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" below is done in the above vundle slab
" filetype plugin indent on


" Escape substitutes
imap jj <Esc>
vmap jj <Esc> 


let mapleader=','

set nu

" for powerline ... ok for airline too I presume (??)
set laststatus=2
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

" tab line navigation short cuts
set showtabline=2
nmap <leader>t :enew<CR>
nmap <leader>d :bnext<CR>
nmap <leader>a :bprevious<CR>
" close current buffer and go to previous
nmap <leader>w :bp <BAR> bd #<CR>
nmap <leader>1 :1b<CR>
nmap <leader>2 :2b<CR>
nmap <leader>3 :3b<CR>
nmap <leader>4 :4b<CR>
nmap <leader>5 :5b<CR>
nmap <leader>6 :6b<CR>
nmap <leader>7 :7b<CR>





" for airline (better than powerline?)
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" manage section truncation
let g:airline#extensions#default#section_truncate_width = {
      \ 'c': 50,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }




syntax on

let python_highlight_all = 1

runtime! ftplugin/man.vim


" for GitGutter
set updatetime=250
