
syntax on

" OLD SHIT

" set nocompatible              " be iMproved, required
"
" " doesn't work!!
" " let &t_SI = "\e[6 q"
" " let &t_EI = "\e[2 q"
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" " reset the cursor on start (for older versions of vim, usually not required)
" augroup myCmds
" au!
" autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END
" set ttimeout
" set ttimeoutlen=1
" set ttyfast
"
" " Added filetype on to fix exit code bug toying with ipython
" filetype on
" filetype off                  " required
"
"
"
" let mapleader=','
"
" set nu
" set relativenumber
"
" " bracket highlight when completed
" set showmatch
" set matchtime=3
"
" " for powerline ... ok for airline too I presume (??)
" set laststatus=2
" set guifont=Inconsolata\ for\ Powerline:h15
" let g:Powerline_symbols = 'fancy'
" set encoding=utf-8
" set t_Co=256
" set fillchars+=stl:\ ,stlnc:\
" set term=xterm-256color
" set termencoding=utf-8
"
" " tab line navigation short cuts
" set showtabline=2
" nmap <leader>t :enew<CR>
" nmap <leader>d :bnext<CR>
" nmap <leader>a :bprevious<CR>
" " close current buffer and go to previous
" nmap <leader>w :bp <BAR> bd #<CR>
" nmap <leader>1 :1b<CR>
" nmap <leader>2 :2b<CR>
" nmap <leader>3 :3b<CR>
" nmap <leader>4 :4b<CR>
" nmap <leader>5 :5b<CR>
" nmap <leader>6 :6b<CR>
" nmap <leader>7 :7b<CR>
"
"
"
"
"
" " for airline (better than powerline?)
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" " manage section truncation
" let g:airline#extensions#default#section_truncate_width = {
"       \ 'c': 50,
"       \ 'x': 60,
"       \ 'y': 88,
"       \ 'z': 45,
"       \ 'warning': 80,
"       \ 'error': 80,
"       \ }
"
"
"
"
" syntax on
" set background=dark
"
" let python_highlight_all = 1
"
" runtime! ftplugin/man.vim
"
"
" " for GitGutter
" set updatetime=250
