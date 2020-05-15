call plug#begin('~/.config/nvim/plugged')

" Plugins {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/restore_view.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'haya14busa/is.vim'
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

" To install
" https://github.com/yuki-ycino/fzf-preview.vim
" https://github.com/mhinz/vim-startify
" }}}
" Themes {{{
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" TODO: Find a good theme
" }}}

call plug#end()

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
set foldmethod=manual
set signcolumn=yes
set inccommand=nosplit
set clipboard+=unnamedplus

set shell=zsh

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

nnoremap <space> <nop>
let mapleader=" "

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
nnoremap <silent> <leader>cr :History:<CR>
nnoremap <silent> <leader>/ :Rg!
nnoremap <silent> <leader>* :Rg! <C-R><C-W><CR>
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
    let g:UltiSnipsExpandTrigger="<C-l>"

    " Edit snippets
    nnoremap <leader>es :CocCommand snippets.editSnippets<CR>

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
" }}}

" UI
let g:netrw_banner = 0     " Hide annoying 'help' banner
let g:netrw_liststyle = 3  " Use tree view
let g:netrw_winsize = '30' " Smaller default window size

set splitbelow
set splitright

" File Find
set path+=**
set wildmenu
set wildignore+=**/node_modules/**

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

augroup CenterOnInsert
    autocmd!
    autocmd InsertEnter * norm zz
augroup END

augroup OverwriteFoldedHiColor
   autocmd!
   autocmd ColorScheme nord highlight Folded guifg=#81A1C1
augroup END

" Autoread inside vim
au FocusGained,BufEnter * :checktime
" }}}

" Keymaps {{{

" Common
nnoremap <leader>fs :w!<CR>
inoremap ,w <Esc>:w!<CR>
nnoremap ; :
nnoremap : ;
map Q <nop>
nnoremap <C-g> :echo expand('%:p')<CR>
nnoremap ,<leader> :b #<cr>
nnoremap <TAB> za

" Insert cool stuff
inoremap <C-CR> <C-o>o

" Quick init.vim changes
nnoremap <space>fie :e ~/.config/nvim/init.vim<cr>
nnoremap <space>fir :so %<cr>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Toggles smart indenting while pasting, A.K.A lifesaver
set pastetoggle=<F6>

" Make Y consistentjwith C and D. See :help Y.
nnoremap Y y$

" make n always search forward and N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" Quickfix list
nnoremap fq :ccl<CR>

" allows incsearch highlighting for range commands
cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>``

" Auto pairs
inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O

" Select pasted text
nnoremap gp `[v`]

" VERY CUSTOM: Paste and format styles to object properties (css-in-js)
nnoremap <leader>sto o<Esc>p<Esc>`[v`]=gv:!st2obj.awk<CR>

" }}}

colorscheme nord

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

