
"{{{ setup
" be vim
set nocompatible
" load vundle
filetype off
"}}}

"{{{ ctrlp
let g:ctrlp_working_path_mode = 2
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \  },
    \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_by_filename = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_dotfiles = 1
let g:ctrlp_mruf_case_sensitive = 0

"}}}

"{{{ paths
" put backups out of the way
set backupdir=~/.vim/backup
set directory=~/.vim/
" persistent undo
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
" always use utf8
set encoding=utf-8
"}}}

"{{{ ui
" Color Scheme in termial vim
colorscheme jellybeans
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

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

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
" detect file type and load plugins & indent rules
filetype plugin indent on
" syntax-aware folds
set foldmethod=syntax
" autoindent by default
set autoindent
"}}}

"{{{ tab completion
" selection method
set wildmenu
" Show list instead of completing
set wildmode=list:longest,full
" files to ignore
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
"}}}

"{{{ syntax
syntax on
set t_Co=256
set background=dark
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
au BufNewFile,BufRead *.json set ft=javascript
" add some ruby types
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufRead,BufNewFile *.less set ft=css
" .mg/config is a gitconfig file
au BufRead,BufNewFile *.mg/config set ft=gitconfig
" use 2 spaces in xml
au FileType xml set expandtab sw=2 sts=2
" use 4 spaces in java
au FileType java set expandtab sw=4 sts=4
" use tabs in makefiles
au FileType make set noexpandtab
" allow modelines
set modeline
" search for modelines in first and last 10 lines
set modelines=10
"}}}

"{{{ mappings
" use kj as a quicker <Esc>
inoremap kj <Esc>
" use ; as a quicker :
map ; :
" move ; to ;;
noremap ;; ;
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
cnoremap %% <C-R>=expand(
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
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
let g:snips_author = 'Rob Johnson'

" NerdTree
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeWinSize = 50

"
" Indent Guides
" For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" }

" YouCompleteMe
let g:ycm_seed_identifiers_with_syntax = 1
" dont want any random buffers popping up
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
" prevent interference with eclim locate buffer"
let g:ycm_filetype_blacklist = {
    \ 'locate_prompt' : 1,
    \ 'notes' : 1,
    \ 'markdown' : 1,
    \ 'text' : 1,
\}

autocmd BufEnter * lcd %:p:h
" Close vim if the only left window open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <Leader>n :NERDTreeToggle<CR>
let g:gist_private = 1
let g:Powerline_symbols = 'compatible'
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

"{{{ automcomplete stuff
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1
" }}}

"{{{ eclim stuff
let g:EclimJavaImportExclude = [ "^com\.sun\..*", "^sun\..*", "^sunw\..*" ]
let g:EclimJavaImportPackageSeparationLevel = 0
let g:EclimJavaSearchSingleResult = 'tabnew'
let g:EclimValidateSortResults = 'severity'
let g:EclimLogLevel = 2
let g:EclimSignLevel = 3
let g:EclimLocateFileFuzzy = 0
let g:EclimCompletionMethod = 'omnifunc'
"}}}

"{{{ vundle
  set rtp+=~/.vim/bundle/vundle/
   call vundle#rc()
    " let Vundle manage Vundle
    Bundle 'gmarik/vundle'
    " Nerd Tree
    Bundle 'scrooloose/nerdtree'
    " Snipmate + dependencies
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    " Syntastic
    Bundle 'scrooloose/syntastic'
    " CtrlP
    Bundle 'kien/ctrlp.vim'
    " Surround
    Bundle 'tpope/vim-surround'
    " Fugitive
    Bundle 'tpope/vim-fugitive'
    " Jelly Beans Color Scheme
    Bundle 'nanotech/jellybeans.vim'
    " Autoclose
    Bundle 'spf13/vim-autoclose'
    " Vim Indent Guides
    Bundle 'nathanaelkane/vim-indent-guides'
    " Gutter
    Bundle 'airblade/vim-gitgutter'
    " Tabularize
    Bundle 'godlygeek/tabular'
    " Tagbar
    Bundle 'majutsushi/tagbar'
    " Preview
    Bundle 'spf13/vim-preview'
    " Rooter
    Bundle 'airblade/vim-rooter'
    " YouCompleteMe
    Bundle 'Valloric/YouCompleteMe'

    "Language Bundles
    " Rails
    Bundle 'tpope/vim-rails'
    " Markdown
    Bundle 'tpope/vim-markdown'
    " Cucumber
    Bundle 'tpope/vim-cucumber'
    Bundle 'quentindecock/vim-cucumber-align-pipes'
    " Puppet
    Bundle 'Puppet-Syntax-Highlighting'
    " HTML
    Bundle 'amirh/HTML-AutoCloseTag'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'tpope/vim-haml'
    Bundle 'chaquotay/ftl-vim-syntax'
    " Javascript
    Bundle 'elzr/vim-json'
    Bundle 'groenewege/vim-less'
    Bundle 'pangloss/vim-javascript'
    Bundle 'briancollins/vim-jst'
    Bundle 'kchmck/vim-coffee-script'
    " Java
    Bundle 'eddking/eclim-vundle'
    " Objective C    
    Bundle 'msanders/cocoa.vim'
" }}}

" vim: set foldmethod=marker:
