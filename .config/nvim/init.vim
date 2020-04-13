call plug#begin('~/.config/nvim/plugged')

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

" Base Config {{{

set encoding=utf-8

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set relativenumber          " add line numbers
set termguicolors           " Use term colors
set cursorline              " Current line highlight
set mouse=a                 " Allow mouse usage
set showtabline=0           " Hide tabs line
set numberwidth=5
set updatetime=300          " Increases the speed of git gutter
set foldmethod=marker
set signcolumn=yes

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

let mapleader=","

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Buffers
set hidden                  " TextEdit might fail if hidden is not set.
set autowrite
set autoread

" Search
set hlsearch                " highlight search results
set incsearch
set ignorecase              " case insensitive matching
set smartcase

" }}}

" Backup Config {{{

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

" }}}

" Plugins {{{

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" {{{
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
    nnoremap <silent> <leader>o :GFiles<CR>
    nnoremap <silent> <leader>b :Buffers<CR>
    " nnoremap <silent> <leader>A :Windows<CR>
    " nnoremap <silent> <leader>; :BLines<CR>
    nnoremap <silent> <leader>. :History<CR>
    nnoremap <silent> <leader>/ :Ack
    nnoremap <silent> <leader>gco :GCheckout<CR>

    " Insert
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
" {{{
    let g:NERDSpaceDelims = 1
" }}}
Plug 'airblade/vim-gitgutter'
" {{{
    let g:gitgutter_map_keys = 0

    function! GitGutterNextHunkCycle()
      let line = line('.')
      silent! GitGutterNextHunk
      if line('.') == line
        1
        GitGutterNextHunk
      endif
    endfunction

    nmap ]h :call GitGutterNextHunkCycle()<CR>
    nmap [h <Plug>(GitGutterPrevHunk)

    nmap <leader>gs <Plug>(GitGutterStageHunk)
    nmap <leader>gu <Plug>(GitGutterUndoHunk)
    nmap <leader>gp <Plug>(GitGutterPreviewHunk)

    function! GitStatus()
      let [a,m,r] = GitGutterGetHunkSummary()
      return printf('+%d ~%d -%d', a, m, r)
    endfunction
" }}}
Plug 'blueyed/vim-diminactive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" {{{

    let g:coc_global_extensions = [
      \ 'coc-tsserver'
      \ ]

    if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
      let g:coc_global_extensions += ['coc-prettier']
    endif

    if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
      let g:coc_global_extensions += ['coc-eslint']
    endif

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
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Move between diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Lists mappings
    nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    function! ShowDocIfNoDiagnostic(timer_id)
      if (coc#util#has_float() == 0)
        silent call CocActionAsync('doHover')
      endif
    endfunction

    function! s:show_hover_doc()
      call timer_start(500, 'ShowDocIfNoDiagnostic')
    endfunction

    autocmd CursorHoldI * :call <SID>show_hover_doc()
    autocmd CursorHold * :call <SID>show_hover_doc()

    " Highlight the symbol and its references when holding the cursor.
    augroup highlightSymbol
        autocmd!
        autocmd CursorHold * silent call CocActionAsync('highlight')
    augroup END

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup cocTSConfig
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
    nmap <leader>ac  :CocAction<CR>
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  :CocFix<CR>

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
Plug 'mileszs/ack.vim'
" {{{
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
" }}}
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/lightline.vim'
" {{{
    set noshowmode
    set laststatus=2

    let g:lightline = {
    \ 'colorscheme': 'nord',
    \   'mode_map': {
    \   'n' : 'N',
    \   'i' : 'I',
    \   'R' : 'R',
    \   'v' : 'V',
    \   'V' : 'VL',
    \   "\<C-v>": 'VB',
    \   'c' : 'C',
    \   's' : 'S',
    \   'S' : 'SL',
    \   "\<C-s>": 'SB',
    \   't': 'T',
    \ },
    \ 'active': {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch', 'gitstatus', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'cocstatus', 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \   'gitbranch': 'FugitiveHead',
    \   'gitstatus': 'GitStatus',
    \ },
    \ }
" }}}

" }}}

" UI {{{

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let airline#extensions#whitespace#enabled = 0

let g:netrw_banner = 0     " Hide annoying 'help' banner
let g:netrw_liststyle = 3  " Use tree view
let g:netrw_winsize = '30' " Smaller default window size

set splitbelow
set splitright

" }}}

" File Find {{{

set path+=**
set wildmenu
set wildignore+=**/node_modules/**

" }}}

" Common Autocmd {{{

augroup cursorLineOnActivePaneOnly
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

augroup removeTraillingSpaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup restoreCursor
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

augroup foldMethodMarkerOnVimFiles
    autocmd!
    autocmd FileType vim,.zshrc setlocal foldmethod=marker
augroup END

" }}}

" Keymaps {{{

" Common
nnoremap <leader>w :w!<CR>
inoremap <leader>w <Esc>:w!<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>s :set invspell<CR>
nnoremap ; :
map Q <nop>
map <C-t> :tabn<CR>
map <CR> o<Esc>
inoremap jj <Esc>
vnoremap <leader><space> <Esc>
nnoremap <space> za

" Terminal keymaps
tnoremap <C-q> <C-\><C-n>
nnoremap <leader>ts :sp \| term<CR>
nnoremap <leader>tv :vsp \| term<CR>

" Remap arrow keys
nnoremap <down> :tabprev<CR>
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>

" Auto insert closing pairs
inoremap {<CR> {<CR>}<ESC>O

" Change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" Windows/Buffers motion keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v
nnoremap <C-b> :b#<CR>
inoremap <C-b> <Esc>:b#<CR>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Toggles smart indenting while pasting, A.K.A lifesaver
set pastetoggle=<F6>

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" Tab shortcuts
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>

" Tab for autocompletion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Yank to clipboard
nnoremap <leader>y "*y

" }}}

" Colors Themes {{{

Plug 'arcticicestudio/nord-vim'

" }}}

call plug#end()

colorscheme nord

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

