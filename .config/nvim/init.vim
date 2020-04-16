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
set number relativenumber   " add line numbers
set termguicolors           " Use term colors
set cursorline              " Current line highlight
set mouse=a                 " Allow mouse usage
set showtabline=0           " Hide tabs line
set numberwidth=5
set updatetime=300          " Increases the speed of git gutter
set foldmethod=manual
set signcolumn=yes
set inccommand=nosplit

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
    nnoremap <silent> <leader>o :GFiles<CR>
    nnoremap <silent> <leader>b :BLines<CR>
    nnoremap <silent> <leader>. :History<CR>
    nnoremap <silent> <leader>; :Commands<CR>
    nnoremap <silent> <leader>; :History:<CR>
    nnoremap <silent> <leader>/ :Rg <Space>
    nnoremap <silent> <leader>* :Rg <C-R><C-W><CR>
    nnoremap <silent> <F1> :Helptags<CR>
    nnoremap <silent> <leader>gco :GCheckout<CR>

    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'justinmk/vim-sneak'
" {{{

    let g:sneak#s_next = 1
    let g:sneak#use_ic_scs = 1

" }}}
Plug 'moll/vim-bbye'
" {{{
    nnoremap <Leader>q :Bdelete<CR>
" }}}
Plug 'preservim/nerdcommenter'
" {{{
    let g:NERDSpaceDelims = 1
" }}}
Plug 'airblade/vim-gitgutter'
" {{{
    let g:gitgutter_sign_added = '∙'
    let g:gitgutter_sign_modified = '∙'
    let g:gitgutter_sign_removed = '∙'
    let g:gitgutter_sign_modified_removed = '∙'

    let g:gitgutter_highlight_linenrs = 1

    highlight link GitGutterAddLineNr CursorColumn
    highlight link GitGutterChangeLineNr CursorColumn
    highlight link GitGutterDeleteLineNr CursorColumn
    highlight link GitGutterChangeDeleteLineNr CursorColumn

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
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-git',
      \ 'coc-eslint',
      \ 'coc-snippets',
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
    " nmap <silent> gi <Plug>(coc-implementation)
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

    " Show tooltip on cursor hold
    " function! ShowDocIfNoDiagnostic(timer_id)
      " if (coc#util#has_float() == 0)
        " silent call CocActionAsync('doHover')
      " endif
    " endfunction

    " function! s:show_hover_doc()
      " call timer_start(500, 'ShowDocIfNoDiagnostic')
    " endfunction

    " autocmd CursorHoldI * :call <SID>show_hover_doc()
    " autocmd CursorHold * :call <SID>show_hover_doc()

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    " xmap <leader>f  <Plug>(coc-format-selected)
    " nmap <leader>f  <Plug>(coc-format-selected)

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
    " nmap <leader>f  :CocFix<CR>

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
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-startify'
" {{{
    let g:startify_files_number = 5
    let g:startify_session_dir = '~/.config/nvimsessions'
" }}}
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
    \              [ 'cocstatus', 'percent' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \   'gitbranch': 'FugitiveHead',
    \   'gitstatus': 'GitStatus',
    \ },
    \ }
" }}}
Plug 'sirver/UltiSnips'
" {{{

    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<C-l>"

    " Edit snippets
    nnoremap <leader>es :CocCommand snippets.editSnippets<CR>

    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

" }}}
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
" {{{
    let g:tmux_navigator_save_on_switch = 1
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

augroup VimFolding
    autocmd!
    autocmd FileType vim set foldmethod=marker
augroup END

augroup CenterOnInsert
    autocmd!
    autocmd InsertEnter * norm zz
augroup END

" Terminal commands
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" }}}

" Keymaps {{{

" Common
nnoremap <leader>w :w!<CR>
inoremap <leader>w <Esc>:w!<CR>
nnoremap <leader><space> :noh<CR>
nnoremap ; :
nnoremap : ;
" No macros for now
map q <nop>
map Q <nop>
nnoremap <C-t> :tabn<CR>
inoremap jj <Esc>
vnoremap <leader><space> <Esc>
nnoremap <C-g> :echo expand('%:p')<CR>

" Terminal keymaps
tnoremap <leader>. <C-\><C-n>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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

" Windows/Buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v
nnoremap <leader>S :T<CR>
nnoremap <leader>V :VT<CR>
nnoremap <C-b> :b#<CR>
inoremap <C-b> <Esc>:b#<CR>
nnoremap + :res +10<CR>
nnoremap _ :res -10<CR>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Toggles smart indenting while pasting, A.K.A lifesaver
set pastetoggle=<F6>

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" Tab for autocompletion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Yank to clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y

" Quickfix list
nnoremap fq :ccl<CR>

" allows incsearch highlighting for range commands
cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>``

" }}}

" Colors Themes {{{

Plug 'arcticicestudio/nord-vim'

" }}}

call plug#end()

colorscheme nord

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

