" be vim
set nocompatible
" load vundle
filetype off
"}}}


"{{{ paths
" put backups out of the way
set directory=~/.vim/swp
set backupdir=~/.vim/backup/
" persistent undo
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
" always use utf8
set encoding=utf-8
"}}}

"vundle before everything else
"{{{ vundle
  set rtp+=~/.vim/bundle/Vundle.vim
   call vundle#begin()
    " let Vundle manage Vundle
    Plugin 'gmarik/Vundle.vim'
    " Snipmate + dependencies
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    " Syntastic
    Plugin 'scrooloose/syntastic'
    " CtrlP
    Plugin 'kien/ctrlp.vim'
    " Surround
    Plugin 'tpope/vim-surround'
    " Fugitive
    Plugin 'tpope/vim-fugitive'
    " Autoclose
    Plugin 'spf13/vim-autoclose'
    " Vim Indent Guides
    Plugin 'nathanaelkane/vim-indent-guides'
    " Gutter
    Plugin 'airblade/vim-gitgutter'
    " Tabularize
    Plugin 'godlygeek/tabular'
    " Tagbar
    Plugin 'majutsushi/tagbar'
    " Preview
    Plugin 'spf13/vim-preview'
    " Rooter
    Plugin 'airblade/vim-rooter'
    " YouCompleteMe
    Plugin 'Valloric/YouCompleteMe'
    " Comments
    Plugin 'scrooloose/nerdcommenter'
    " Colors
    Plugin 'flazz/vim-colorschemes'

    "Language Plugins
    " Rails
    Plugin 'tpope/vim-rails'
    " Markdown
    Plugin 'tpope/vim-markdown'
    " Cucumber
    Plugin 'tpope/vim-cucumber'
    Plugin 'quentindecock/vim-cucumber-align-pipes'
    " Puppet
    Plugin 'Puppet-Syntax-Highlighting'
    " HTML
    Plugin 'amirh/HTML-AutoCloseTag'
    Plugin 'hail2u/vim-css3-syntax'
    Plugin 'tpope/vim-haml'
    Plugin 'chaquotay/ftl-vim-syntax'
    " Javascript
    Plugin 'elzr/vim-json'
    Plugin 'groenewege/vim-less'
    Plugin 'pangloss/vim-javascript'
    Plugin 'briancollins/vim-jst'
    Plugin 'kchmck/vim-coffee-script'
    " Java
    Plugin 'eddking/eclim-vundle'
    " Objective C
    Plugin 'msanders/cocoa.vim'
    " Python
    Plugin 'hdima/python-syntax'
    " Haskell
    Plugin 'lukerandall/haskellmode-vim'
    " Go
    Plugin 'fatih/vim-go'
    " Ansible
    Plugin 'chase/vim-ansible-yaml'
    " Node
    Plugin 'moll/vim-node'
    Plugin 'marijnh/tern_for_vim'
    " JS
    Plugin 'jelera/vim-javascript-syntax'
    " Jinja
    Plugin 'mitsuhiko/vim-jinja'
    " Typescript
    Plugin 'leafgarland/typescript-vim'
    " Lisps
    Plugin 'kovisoft/slimv'
    " All of your Plugins must be added before the following line
    call vundle#end()
    filetype plugin indent on
" }}}

"{{{ ui
" Color Scheme in termial vim
colorscheme molokai
set background=dark
" show line numbers
set number
" show file position
set ruler
" show column
set cursorcolumn
" show line
set cursorline
" always show status bar
set laststatus=2
" make backspace do what you expect
set backspace=indent,eol,start
" use abbreviations in messages
set shortmess=aI
" always set terminal title
set title
" don't put ugly |s into vbars
set fillchars=vert:\ 
" always leave 5 lines around cursor
set scrolloff=5
set sidescrolloff=5
" save history
set viminfo=/50,'50,:50,h
" don't update screen for macros
set lazyredraw
set viewoptions=folds,options,cursor,unix,slash
" all folds open by default
autocmd BufEnter * let PreFoldPosition = getpos('.') | silent! %foldopen! | call setpos('.', PreFoldPosition)
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
syntax on
set t_Co=256
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
" gradle = groovy
au BufNewFile,BufRead *.gradle setf groovy
" json = js
autocmd BufNewFile,BufRead *.template set filetype=json
" add some ruby types
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
" Haskell 
au BufEnter *.hs compiler ghc
" use 2 spaces in xml
au FileType xml set expandtab sw=2 sts=2
" use 4 spaces in java
au FileType java set expandtab sw=4 sts=4
" use 4 spaces in python
au FileType python set expandtab sw=4 sts=4
" use 4 spaces in typescript
au FileType typescript set expandtab sw=4 sts=4
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
" use kj as a quicker <Esc>
inoremap kj <Esc>
" use ; as a quicker :
map ; :
" open netrw
map <Leader>n :E<CR>
" move ; to ;;
noremap ;; ;
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" press F2 before a paste to turn off autoindent
set pastetoggle=<F2>
" create blank line without entering insert
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
" w!! to save with sudo
cmap w!! %!sudo tee > /dev/null %
" use space to pagedown
noremap <Space> <PageDown>
" Default leader is \ replace with ,
let mapleader = ','
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

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
set modifiable
"Fix 256-color
set t_ut=
"}}}

"{{{ misc plugin settings
" my name for snippets
let g:snips_author    = 'Rob Johnson'
let g:haddock_browser = "/Applications/Google Chrome.app"

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" }

" Speed Git Gutter Up
let g:gitgutter_eager=0
let g:gitgutter_realtime = 0

" YouCompleteMe
let g:ycm_seed_identifiers_with_syntax = 1
" dont want any random buffers popping up
set completeopt-=preview
" close the completion window once I've made a selection 
let g:ycm_add_preview_to_completeopt = 0
" prevent interference with eclim locate buffer"
let g:ycm_filetype_blacklist = {
    \ 'locate_prompt' : 1,
    \ 'notes'         : 1,
    \ 'markdown'      : 1,
    \ 'text'          : 1,
    \ 'plaintex'      : 1,
    \ 'tex'           : 1,
\}


" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \  },
    \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_dotfiles = 1

" python
let python_highlight_all = 1

autocmd BufEnter * lcd %:p:h

let g:gist_private = 1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['java'] }
"}}}

"{{{ clever bits
" remember last file location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

augroup FTMisc
  " save when losing focus, update fugitive status when gaining
  autocmd FocusLost   * silent! wall
  autocmd FocusGained * silent! call fugitive#reload_status()

" chmod +x new files on save if they start with hashbang
  autocmd BufNewFile  * let b:chmod_exe=1
  autocmd BufWritePre * if exists("b:chmod_exe") |
        \ unlet b:chmod_exe |
        \ if getline(1) =~ '^#!' | let b:chmod_new="+x" | endif |
      \ endif
  autocmd BufWritePost,FileWritePost * if exists("b:chmod_new")|
        \ silent! execute "!chmod ".b:chmod_new." <afile>"|
        \ unlet b:chmod_new|
        \ endif
  " allow browsing inside jars
  autocmd BufReadCmd *.jar call zip#Browse(expand("<amatch>"))
  augroup END

  au BufNewFile,BufRead *.ftl set ft=html.ftl
  au FileType puppet set et sw=4 sts=4
  
  " Strip whitespace
  function! StripTrailingWhitespace()
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    if !exists('g:spf13_keep_trailing_whitespace')
      " Preparation: save last search, and cursor position.
      let _s=@/
      let l = line(".")
      let c = col(".")
      " do the business:
      %s/\s\+$//e
      " clean up: restore previous search history, and cursor position
      let @/=_s
      call cursor(l, c)
    endif
  endfunction

"}}}


"{{{ go stuff 
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
"}}}"
"
" vim: set foldmethod=marker:
