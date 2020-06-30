call plug#begin('~/.config/nvim/plugged')

" Plugins {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mike-hearn/vim-combosearch'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-scripts/restore_view.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-anzu'
Plug 'sheerun/vim-polyglot'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'blueyed/vim-diminactive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vimwiki/vimwiki'
Plug 'benmills/vimux'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-dirvish'
Plug 'Valloric/MatchTagAlways'
Plug 'AndrewRadev/tagalong.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-test/vim-test'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-obsession'
Plug 'tommcdo/vim-exchange'
" Plug 'roman/golden-ratio' TODO: Excellent, but I need to disable on git diff

" Next
" Learn about spell
" tommcdo/vim-exchange
" kassio/neoterm
" }}}
" Themes {{{
Plug 'jacoborus/tender.vim'
" }}}

call plug#end()

colorscheme tender

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
set inccommand=nosplit
set backspace=indent,eol,start
set shell=zsh

" Difftool
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

" Buffers
set hidden                  " TextEdit might fail if hidden is not set.
set autowrite
set autoread

" Search
set incsearch
set ignorecase              " case insensitive matching
set smartcase

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
set swapfile

" Plugins Config

" Fzf {{{
let g:fzf_history_dir = '~/.config/nvim/fzf-history'

" Hide status line while fzf is opened
autocmd! FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! s:open_branch_fzf(line)
    let l:parser = split(a:line)
    let l:branch = l:parser[0]
    if l:branch ==? '*'
        let l:branch = l:parser[1]
    endif
    execute '!git checkout ' . l:branch
endfunction

command! -bang -nargs=0 GCheckout
            \ call fzf#vim#grep(
            \   'git branch -v', 0,
            \   {
            \     'sink': function('s:open_branch_fzf')
            \   },
            \   <bang>0
            \ )

" Maps
nnoremap <silent> <leader>h :Helptags<CR>
nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <C-f> :BLines<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>fr :History<CR>
nnoremap <silent> <leader>fc :History:<CR>
nnoremap <silent> <leader>fl :Rg!<space>
nnoremap <silent> <leader>* :Rg! <C-R><C-W><CR>
vnoremap <silent> <leader>* y:Rg! <C-r>0<CR>
nnoremap <silent> <leader>gc :GCheckout<CR>
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
" Go {{{
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
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

" ComboSearch config
let g:combosearch_trigger_key = "<c-p>"

" }}}
" Emmet {{{
let g:user_emmet_settings = {
            \  'javascript' : {
            \      'extends' : 'jsx',
            \  },
            \}
" }}}
" Coc {{{
let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-prettier',
            \ 'coc-eslint',
            \ 'coc-snippets',
            \ 'coc-python',
            \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Restart
nnoremap <leader>cr :<C-u>CocRestart<cr>
nnoremap <leader>cc :<C-u>CocConfig<cr>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Lists mappings
nnoremap <silent> <leader>di :<C-u>CocList diagnostics<cr>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup cocTSConfiguration
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nnoremap <leader>ac  :CocAction<CR>

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" }}}
" Snippets {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"

" Edit snippets
nnoremap <leader>csl :CocCommand snippets.editSnippets<CR>
nnoremap <leader>css :UltiSnipsEdit

" Use <C-e> for trigger snippet expand.
imap <C-e> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" }}}
" Tmux nav {{{
let g:tmux_navigator_save_on_switch = 1
" }}}
" Airline {{{
let g:airline_extensions = ['coc']
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

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
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
" tagalong {{{
let g:tagalong_additional_filetypes = ['javascript']
" }}}
" autopairs {{{
inoremap <C-l> <Esc>:call AutoPairsJump()<cr>a
" }}}
" Test {{{
let test#strategy = "neovim"
" }}}
" vim-sandwich {{{
runtime macros/sandwich/keymap/surround.vim
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

" augroup CenterOnInsert
"     autocmd!
"     autocmd InsertEnter * norm zz
" augroup END

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

" Autoread inside vim
au FocusGained,BufEnter * :checktime
" }}}
" Keymaps {{{

" Common
nnoremap <leader>fs :w!<CR>
nnoremap ; :
nnoremap : ;
map Q <nop>
nnoremap <C-g> :echo expand('%:p')<CR>
nnoremap ,<leader> :b #<cr>

" Insert cool stuff
inoremap <C-b> <left>
inoremap <C-CR> <C-o>o
inoremap <C-k> <cr><C-o>O
inoremap <C-s> <c-o>:w<cr>

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

" Terminal
if has('nvim')
    tmap <C-o> <C-\><C-n>
endif

" }}}

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting


