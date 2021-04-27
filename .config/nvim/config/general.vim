call plug#begin('~/.config/nvim/plugged')

" TODO: Temporal...
let g:vimspector_enable_mappings = 'HUMAN'

function! s:local_plug(package_name) abort " {{{
  if isdirectory(expand('~/own-projects/nvplugins/' . a:package_name))
    execute "Plug '~/own-projects/nvplugins/" . a:package_name . "'"
  endif
endfunction
" }}}

" Polyglot config
let g:polyglot_disabled = ['autoindent']

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
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'
Plug 'Valloric/MatchTagAlways'
Plug 'AndrewRadev/tagalong.vim'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'
Plug 'markonm/traces.vim'
Plug 'dense-analysis/ale'
Plug 'nathunsmitty/nvim-ale-diagnostic'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'cohama/lexima.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'hrsh7th/vim-vsnip'          " Only for LSP Snippets
Plug 'hrsh7th/vim-vsnip-integ'    " Only for LSP Snippets
Plug 'tsiemens/vim-aftercolors'
Plug 'puremourning/vimspector'
Plug 'glepnir/lspsaga.nvim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tpope/vim-obsession'
Plug 'RRethy/vim-illuminate'
Plug 'justinmk/vim-sneak'
Plug 'szw/vim-maximizer'

" TODO: Take a look at this
" https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
" lightline lua alternatives
" https://github.com/glepnir/galaxyline.nvim -> Lightline replacement
" https://github.com/tjdevries/express_line.nvim
" https://github.com/hoob3rt/lualine.nvim

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'fhill2/telescope-ultisnips.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Local plugins
call s:local_plug('lsp_extensions.nvim')

" }}}

" Themes {{{
Plug 'jacoborus/tender.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'arcticicestudio/nord-vim'
Plug 'adrian5/oceanic-next-vim'
Plug 'romainl/Apprentice'
Plug 'glepnir/zephyr-nvim'
Plug 'tanvirtin/nvim-monokai'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" }}}

call plug#end()

" colorscheme base16-dracula
" colorscheme base16-gruvbox-dark-medium
colorscheme base16-gruvbox-light-medium

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
" set showmatch               " show matching brackets
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=2            " width for autoindents
set expandtab               " converts tabs to white space
set number relativenumber   " add line numbers
set termguicolors           " Use term colors
set cursorline              " Current line highlight
set mouse=a                 " Allow mouse usage
set numberwidth=5
set updatetime=250          " Increases the speed of git gutter
set foldnestmax=2
set signcolumn=yes
set shell=zsh
set pumheight=10
set nowrap

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

set diffopt+=vertical

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

let mapleader=" "

set scrolloff=2
set sidescroll=5

set confirm
set laststatus=2
set viewoptions=cursor,folds,slash,unix

" Buffers
" TextEdit might fail if hidden is not set.
set hidden
set autowrite

" Search
set ignorecase
set smartcase

" Markdown languages
let g:markdown_fenced_languages = ['css', 'js=javascript', 'javascript', 'json=javascript', 'bash']

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
set wildignore+=**/node_modules/**
set wildcharm=<C-Z>
set wildignorecase

" vim:sw=2 ts=2 et
