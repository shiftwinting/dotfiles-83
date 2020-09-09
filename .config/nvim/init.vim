call plug#begin('~/.config/nvim/plugged')

" Plugins {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'haya14busa/is.vim'
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
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'dense-analysis/ale'
Plug 'blueyed/vim-diminactive'
Plug 'zhimsel/vim-stay'

" To check if good for my workflow
" Plug 'tpope/vim-obsession'

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

lua require('lspserver')

" Diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1

" Completion
inoremap <silent><expr> <c-space> completion#trigger_completion()
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_items_priority = {
            \ 'Field': 11,
            \ 'Function': 7,
            \ 'Variables': 7,
            \ 'Method': 10,
            \ 'Interfaces': 5,
            \ 'Constant': 5,
            \ 'Class': 5,
            \ 'Keyword': 4,
            \ 'UltiSnips' : 1,
            \ 'vim-vsnip' : 0,
            \ 'Buffers' : 1,
            \ 'TabNine' : 0,
            \ 'File' : 1,
            \}

" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <space>ac     <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <space>rn     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>gr     <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> [g            :<c-u>PrevDiagnosticCycle<CR>
nnoremap <silent> ]g            :<c-u>NextDiagnosticCycle<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Plugins Config

" Fzf {{{
let g:fzf_history_dir = '~/.config/nvim/fzf-history'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Maps
nnoremap <silent> <leader>h :Helptags<CR>
nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <C-f> :BLines<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>fr :History<CR>
nnoremap <silent> <leader>fc :History:<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>rg :Rg!<CR>
nnoremap <silent> <leader>fl :Rg!<space>
nnoremap <silent> <leader>* :Rg! <C-R><C-W><CR>
vnoremap <silent> <leader>* y:Rg! <C-r>0<CR>
cnoremap <C-e> <C-c>:Commands<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" }}}
" Vim go {{{
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1

" nnoremap <leader>gd :<C-u>GoDiagnostics<cr>
" }}}
" Polyglot {{{
let g:polyglot_disabled = ['go']
" }}}
" bbye {{{
nnoremap <Leader>q :Bdelete<CR>
" }}}
" Git {{{
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_modified_removed = '▌'
let g:gitgutter_realtime = 1
highlight GitGutterDelete guifg=#F97CA9
highlight GitGutterAdd    guifg=#BEE275
highlight GitGutterChange guifg=#96E1EF

let g:gitgutter_map_keys = 0

function! GitGutterNextHunkCycle()
    let line = line('.')
    silent! GitGutterNextHunk
    if line('.') == line
        1
        GitGutterNextHunk
    endif
endfunction

nnoremap ]h :call GitGutterNextHunkCycle()<CR>
nmap [h <Plug>(GitGutterPrevHunk)

nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)

" }}}
" Emmet {{{
let g:user_emmet_settings = {
            \  'javascript' : {
            \      'extends' : 'jsx',
            \  },
            \}
" }}}
" Tmux nav {{{
let g:tmux_navigator_save_on_switch = 1
" }}}
" Vimwiki {{{
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
" }}}
" Vimux {{{
nnoremap <leader>vl :w<CR>:<C-u>VimuxRunLastCommand<CR>
inoremap <leader>vl <Esc>:w<CR>:<C-u>VimuxRunLastCommand<CR>

function! VimuxSlime()
    if !exists("g:VimuxRunnerIndex")
        call VimuxOpenRunner()
    endif
    silent call VimuxSendText(@v)
    " call VimuxSendKeys("Enter")
endfunction

vnoremap <leader>vs "vygv<C-c>:call VimuxSlime()<CR>
nnoremap <leader>vs i<Esc>"vyip:call VimuxSlime()<CR>gi<Esc>l
inoremap <leader>vs <Esc>"vyip:call VimuxSlime()<CR>gi
" }}}
" Fugitive {{{
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
" }}}
" incsearch {{{
let g:asterisk#keeppos = 1

cmap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<C-g>" : "<C-Z>"
cmap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<C-t>" : "<S-Tab>"

" }}}
" MatchTagAlways {{{
let g:mta_filetypes = {
            \ 'html' : 1,
            \ 'xhtml' : 1,
            \ 'xml' : 1,
            \ 'jinja' : 1,
            \ 'javascript' : 1,
            \}
" }}}
" Tagalong {{{
let g:tagalong_additional_filetypes = ['javascript']
" }}}
" Test {{{
let test#strategy = "neovim"
" }}}
" Yank Highlight {{{
let g:highlightedyank_highlight_duration = 400
"}}}
" vim-sandwich {{{
runtime macros/sandwich/keymap/surround.vim
" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsSnippetDirectories=["own_snippets"]

nnoremap <space>ee :UltiSnipsEdit<CR>
" }}}
" ALE {{{
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'vue': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_hover_to_preview = 1
" }}}
" Lightline {{{
let g:lightline = {
\  'colorscheme': 'tender',
\  'active': {
\    'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filenameOrLastFolderOfIndex', 'modified' ] ]
\  },
\  'component_function': {
\    'gitbranch': 'fugitive#head',
\    'filenameOrLastFolderOfIndex': 'LightLineFixIndexFiles'
\  },
\  'mode_map': {
\    'n' : 'N',
\    'i' : 'I',
\    'R' : 'R',
\    'v' : 'V',
\    'V' : 'VL',
\    "\<C-v>": 'VB',
\    'c' : 'C',
\    's' : 'S',
\    'S' : 'S',
\    "\<C-s>": 'SB',
\    't': 'T',
\  }
\ }

function! LightLineFixIndexFiles()
    let filenameonly = split(expand('%:t:r'), '\.')

    if !len(filenameonly)
        return ''
    endif

    if filenameonly[0] ==? 'index'
        return remove(split(expand('%:h'), '/'), -1) . '/' . expand('%:t')
    else
        return expand('%:t')
    endif
endfunction
" }}}

set splitbelow
set splitright

" File Find
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set wcm=<C-Z>

" Common Autocmd {{{
augroup cursorLineOnActivePaneOnly
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

augroup disableAutoComments
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=q formatoptions-=n formatoptions-=r formatoptions-=o formatoptions-=l
augroup END

augroup removeTraillingSpaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup foldMethodMarkerOnVimFiles
    autocmd!
    autocmd FileType vim,zsh setlocal foldmethod=marker
augroup END

augroup OverwriteFoldedHiColor
    autocmd!
    autocmd ColorScheme nord highlight Folded guifg=#81A1C1
augroup END

augroup Dirvish
    autocmd!
    autocmd FileType dirvish nnoremap <buffer> <leader>n :edit %
    autocmd FileType dirvish nnoremap <buffer> <leader>m :!mkdir %
    autocmd FileType dirvish nnoremap <buffer> <leader>t :!touch %
augroup END

au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

augroup Vue
    autocmd!
    autocmd FileType vue setlocal commentstring=\/\/\ %s
augroup END

augroup templates
    autocmd!
    autocmd BufNewFile *.editorconfig 0r ~/.config/nvim/templates/.editorconfig
augroup END

augroup LSP
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
augroup END

" Highlight yank
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}

" Autoread inside vim
au FocusGained,BufEnter * :checktime

augroup stay_no_lcd
  autocmd!
  autocmd User BufStaySavePre  if haslocaldir() | let w:lcd = getcwd() | cd - | cd - | endif
  autocmd User BufStaySavePost if exists('w:lcd') | execute 'lcd' fnameescape(w:lcd) | unlet w:lcd | endif
augroup END
" }}}
" Keymaps {{{

" Common
nnoremap <leader>w :w!<CR>
nnoremap ; :
nnoremap : ;
map Q <nop>
nnoremap <C-g> :echo expand('%')<CR>
nnoremap ,<leader> :b #<cr>

" Insert cool stuff
inoremap <C-b> <left>
inoremap <C-CR> <C-o>o
inoremap <C-s> <Esc>:w<cr>

" Brackets
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O

" Quick init.vim changes
nnoremap <space>ie :e ~/.config/nvim/init.vim<cr>
nnoremap <space>ir :so %<cr>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Make Y consistentjwith C and D. See :help Y.
nnoremap Y y$

" make n always search forward and N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" :noh for the win!
nnoremap <CR> :noh<CR><CR>

" TODO: Add one for spellchecking.

" Fold
nnoremap <leader>z za

" Windows
nnoremap <leader>wh :split<cr>
nnoremap <leader>wv :vsplit<cr>
nnoremap <leader>wd :<C-u>q<cr>

" Allows incsearch highlighting for range commands
cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>``

" Clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" Select pasted text
nnoremap gp `[v`]

" VERY CUSTOM: Paste and format styles to object properties (css-in-js)
nnoremap <leader>sto o<Esc>p<Esc>`[v`]=gv:!st2obj.awk<CR>

" Add numbered jumps to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" }}}
