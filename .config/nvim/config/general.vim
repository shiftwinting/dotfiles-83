call plug#begin('~/.config/nvim/plugged')

function! s:local_plug(package_name) abort " {{{
  if isdirectory(expand('~/own-projects/nvplugins/' . a:package_name))
    execute "Plug '~/own-projects/nvplugins/" . a:package_name . "'"
  endif
endfunction
" }}}

" Plugins {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'sheerun/vim-polyglot'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vimwiki/vimwiki'
Plug 'benmills/vimux'
Plug 'justinmk/vim-dirvish'
Plug 'Valloric/MatchTagAlways'
Plug 'AndrewRadev/tagalong.vim'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'
Plug 'markonm/traces.vim'
Plug 'diepm/vim-rest-console'
Plug 'dense-analysis/ale'
Plug 'blueyed/vim-diminactive'
Plug 'zhimsel/vim-stay'
Plug 'steelsojka/completion-buffers'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-scriptease'

" Lua
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/plenary.nvim'

" Local plugins
call s:local_plug('lsp_extensions.nvim')

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" }}}

" Themes {{{
Plug 'jacoborus/tender.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
" }}}

call plug#end()

colorscheme tender
" colorscheme solarized
set background=dark

let nvimDir  = '$HOME/.config/nvim'
let cacheDir = expand(nvimDir . '/.cache')

" Basic Functions {{{
function! CreateAndExpand(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), 'p')
    endif

    return expand(a:path)
endfunction
" }}}

" Base Config
set encoding=utf-8
set linebreak
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number relativenumber   " add line numbers
set termguicolors           " Use term colors
set cursorline              " Current line highlight
set mouse=a                 " Allow mouse usage
set showtabline=0           " Hide tabs line
set numberwidth=5
set updatetime=250          " Increases the speed of git gutter
set showcmd                 " Show incomplete commands
set foldmethod=manual
set foldnestmax=2
set signcolumn=yes
set backspace=indent,eol,start
set shell=zsh
set showtabline=1

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

set diffopt+=vertical

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

let mapleader=" "

set scrolloff=5
set sidescroll=5

set confirm
set laststatus=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set viewoptions=cursor,folds,slash,unix

" Buffers
set hidden                  " TextEdit might fail if hidden is not set.
set autowrite
set autoread

" Search
set incsearch
set ignorecase              " case insensitive matching
set smartcase

set pastetoggle=<F10>

" Markdown languages
let g:markdown_fenced_languages = ['css', 'js=javascript', 'javascript', 'json=javascript', 'bash']

" Backup Config
set history=1000 " Remember everything
set undolevels=1000

" Nice persistent undos
let &undodir=CreateAndExpand(cacheDir . '/undo')
set undofile

" Keep backups
let &backupdir=CreateAndExpand(cacheDir . '/backup')
set backup

" Keep swap files, can save your life
let &directory=CreateAndExpand(cacheDir . '/swap')
set noswapfile

filetype plugin indent on   " allows auto-indenting depending on file type
syntax enable               " syntax highlighting

set splitbelow
set splitright

" File Find
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set wcm=<C-Z>
