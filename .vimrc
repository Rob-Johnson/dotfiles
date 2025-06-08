"{{{ paths
" put backups out of the way
set directory=~/.vim/swp
set backupdir=~/.vim/backup/
" persistent undo
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
set undofile
" always use utf8
set encoding=utf-8
"}}}

"{{{ plugins - vim-plug
call plug#begin('~/.vim/plugged')
    " Core plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'godlygeek/tabular'
    Plug 'airblade/vim-rooter'
    
    " UI and navigation
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Yggdroot/indentLine'
    
    " Git integration  
    Plug 'airblade/vim-gitgutter'
    
    " Linting and completion
    Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    " Color schemes
    Plug 'morhetz/gruvbox'
    Plug 'tomasr/molokai'
    
    " Language support
    Plug 'plasticboy/vim-markdown'
    Plug 'rodjek/vim-puppet'
    Plug 'vim-python/python-syntax'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'wlangstroth/vim-racket'
    Plug 'bhurlow/vim-parinfer'
    
call plug#end()
filetype plugin indent on
"}}}

"{{{ modern terminal support
" True color support for ghostty
if has('termguicolors')
  set termguicolors
endif

" Better terminal integration
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Mouse support
set mouse=a

" Clipboard integration
if has('clipboard')
  set clipboard=unnamedplus
endif
"}}}

"{{{ completion and wildmenu
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/node_modules/*
set completeopt=menu,menuone,noselect
"}}}

"{{{ ui
" Color scheme
try
  colorscheme gruvbox
  set background=dark
catch
  colorscheme molokai
  set background=dark
endtry

" Line numbers with relative for better navigation
set number
set relativenumber

" UI improvements
set ruler
set cursorline
set laststatus=2
set backspace=indent,eol,start
set shortmess+=c
set title
set fillchars=vert:│,fold:·,diff:·
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes

" Performance
set lazyredraw
set updatetime=300
set timeoutlen=500

" Split behavior
set splitbelow
set splitright

" Better folding
set foldmethod=indent
set foldlevelstart=10
set foldnestmax=10
"}}}

"{{{ whitespace
" default indent 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
" I hate tabs so they should be spaces
set expandtab
" highlight tabs & trailing spaces
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace"
" detect file type and load plugins & indent rule
filetype plugin indent on
" autoindent by default
set autoindent
"}}}

"{{{ syntax
syntax enable
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
"}}}

"{{{ search
" highlight last search term
set hlsearch
" incremental search
set incsearch
" case insensitive
set ignorecase
" case sensitive if search string contains uppercase
set smartcase
" always replace all matches on line
set gdefault
" Magic for regex
set magic
"}}}

"{{{ filetypes
" json = js
autocmd BufNewFile,BufRead *.template set filetype=json
" add some ruby types
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
" Haskell
au BufEnter *.hs compiler ghc
" use 2 spaces in xml
au FileType xml set expandtab sw=2 sts=2
" use 4 spaces in python
au FileType python set expandtab sw=4 sts=4
" use tabs in makefiles
au FileType make set noexpandtab
" use spellcheck in tex
au FileType plaintex set spell spelllang=en_gb
" allow modelines
set modeline
" search for modelines in first and last 10 lines
set modelines=10
" markdown
au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown set spell spelllang=en_gb
" allow editing crontab
au filetype crontab setlocal nobackup nowritebackup
"}}}

"{{{ mappings
" use ; as a quicker :
map ; :
" move ; to ;;
noremap ;; ;
" Clear search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Paste mode toggle
set pastetoggle=<F2>
" Create blank lines without entering insert
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
" Save with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Leader key
let mapleader = ','
let maplocalleader = '\\'
" Consistent with C and D
nnoremap Y y$
" File explorer
nnoremap <Leader>n :Explore<CR>
" FZF shortcuts
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>h :History<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" " Same for 0, home, end, etc
noremap $ g$
noremap <End> g<End>
noremap 0 g0
noremap <Home> g<Home>
noremap ^ g^

" Disable arrow keys
map  <up> <nop>
map  <down> <nop>
map  <left> <nop>
map  <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"}}}

"{{{ misc vim settings
set autowrite
set virtualedit=block
set hidden
set confirm
set autoread
"}}}

"{{{ plugin settings
" Fugitive
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gl :Git log --oneline<CR>

" ALE (Async Lint Engine)
let g:ale_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" CoC (Conquer of Completion)
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-go',
  \ 'coc-rust-analyzer',
  \ 'coc-yaml',
  \ 'coc-vimlsp'
  \ ]

" FZF
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = { 'down': '~40%' }

" Airline
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1

" Python syntax
let g:python_highlight_all = 1

" IndentLine
let g:indentLine_char = '│'
let g:indentLine_enabled = 1
"}}}

"{{{ clever bits

augroup VimrcAutocmds
  autocmd!
  " Save when losing focus
  autocmd FocusLost * silent! wall
  
  " Auto-reload files changed outside of vim
  autocmd FocusGained,BufEnter * silent! checktime
  
  " Make executable if shebang present
  autocmd BufWritePost * if getline(1) =~ '^#!' | silent execute '!chmod +x <afile>' | endif
  
  " Remove trailing whitespace on save
  autocmd BufWritePre * %s/\s\+$//e
  
  " Return to last edit position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
"}}}


"{{{ language specific
" Go
augroup GoSettings
  autocmd!
  autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>gr <Plug>(go-run)
  autocmd FileType go nmap <Leader>gt <Plug>(go-test)
augroup END

" Enhanced tmux integration
if exists('$TMUX')
  " Better color support in tmux
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  
  " Better split navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
endif
"}}}
"
" vim: set foldmethod=marker:
