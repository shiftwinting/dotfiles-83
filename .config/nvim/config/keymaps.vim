" common
nmap <expr> ; sneak#is_sneaking() ? "\<Plug>Sneak_;" : ":"
map Q <nop>
nnoremap <silent> <CR> :noh \| echo<CR>

" files
nnoremap <leader>fs :w!<CR>
nnoremap <leader>fy <Cmd>let @* = expand('%')<CR>

" quick init.vim changes
nnoremap <silent> <leader>ie :tabe ~/.config/nvim/config/general.vim \| tcd ~/.config/nvim<cr>
nnoremap <silent> <leader>ir :so %<cr>:echo "Config reloaded!"<cr>

" previous buffer
nnoremap <silent> <leader>, :b#<cr>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" make Y consistent with C and D. See :help Y.
nnoremap Y y$

" painless brackets with commas
inoremap {, {<cr>},<C-o>O
inoremap [, [<cr>],<C-o>O
inoremap (, (<cr>),<C-o>O

" select first completion if possible
inoremap <C-x><C-p> <C-x><C-p><C-p>
inoremap <C-x><C-n> <C-x><C-n><C-n>

" insert utils
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <C-o>$
inoremap <C-j> <C-o>o

" make n always search forward and N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" magic search
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/

" better gx
nnoremap <silent> gx :silent execute '!open ' . shellescape(expand('<cWORD>'), 1)<CR>

" hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" fold
nnoremap <leader>z za

" magic actions for search
cnoremap <expr> <C-y> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>:t''<CR>" : "<C-y>"
cnoremap <expr> <C-b> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>:m''<CR>" : "<C-b>"
cnoremap <expr> <C-d> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>:d<CR>``" : "<C-d>"

" better search
cmap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<C-g>" : "<C-Z>"
cmap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<C-t>" : "<S-Tab>"

" tab when pumvisible
imap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"
imap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"

" <c-p> and <c-n> use characters for history
cnoremap <expr> <C-P> wildmenumode() ? "\<C-P>" : "\<Up>"
cnoremap <expr> <C-N> wildmenumode() ? "\<C-N>" : "\<Down>"

" tabs
nnoremap [t gT
nnoremap ]t gt

" clipboard
nnoremap <leader>y "*y
nnoremap <leader>yb V$%y
nnoremap <leader>Y "*y$
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" Tab management
nnoremap <leader><tab>n :tabe<cr>
nnoremap <leader><tab>d :tabc<cr>

" edit relative to current file
nnoremap <leader>eh :e %:h/

" select pasted text
" nnoremap gp `[v`]

" add numbered jumps to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" open current ftplugin file
nnoremap <leader>ef :e ~/.config/nvim/after/ftplugin/<C-R>=&filetype<CR>.vim<CR>

" terminal
tnoremap ,, <C-\><C-n>G
tnoremap <expr> <A-r> '<C-\><C-n>"' . nr2char(getchar()) . 'pi'
nnoremap <leader>oT :term<cr>

" send paragraph under cursor to terminal
function! Exec_on_term(cmd)
  if a:cmd=="normal"
    exec "normal mk\"vyip"
  else
    exec "normal gv\"vy"
  endif
  if !exists("g:last_terminal_chan_id")
    vs
    terminal
    let g:last_terminal_chan_id = b:terminal_job_id
    wincmd p
  endif

  if getreg('"v') =~ "^\n"
    call chansend(g:last_terminal_chan_id, expand("%:p")."\n")
  else
    call chansend(g:last_terminal_chan_id, @v)
  endif
  exec "normal `k"
endfunction

nnoremap <F6> :call Exec_on_term("normal")<CR>
vnoremap <F6> :<c-u>call Exec_on_term("visual")<CR>

" delete element from quickfix list
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction

:command! RemoveQFItem :call RemoveQFItem()

" open the github plugins url
function! OpenPluginDocs()
    let github_path = 'https://github.com/'
    let quotes_text_regex = '\v([''"])(.{-})\1'
    let currentline = trim(getline('.'))
    if matchstr(currentline, '^Plug') == ''
        throw "Current line doesn't match plugin pattern."
    endif
    let plugin_path = matchstr(currentline, quotes_text_regex)[1:-2]
    call system('open ' . github_path . plugin_path)
endfunction

command! OpenPluginDocs :call OpenPluginDocs()

" util to show highlight groups
function! ShowHighlightGroups()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

command! ShowHighlightGroups :call ShowHighlightGroups()

" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf nnoremap <buffer> dd :RemoveQFItem<cr>

" window utils
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

" debug
nnoremap <leader>m :<c-u>ccl \| Messages \| res +20<CR>
" nnoremap <leader>lr :<c-u>lua require('lspsetup.utils').reset_config()<CR>
nnoremap <leader>lp :<c-u>lua print(vim.inspect())<left><left>

" vim:sw=2 ts=2 et
