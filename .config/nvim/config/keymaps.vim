" common
nnoremap <leader>w :w!<CR>
nnoremap ; :
map Q <nop>
nnoremap <CR> :noh<CR><CR>

" quick init.vim changes
nnoremap <leader>ie :tabe ~/.config/nvim/config/general.vim \| tcd ~/.config/nvim<cr>
nnoremap <leader>ir :so %<cr>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" make Y consistent with C and D. See :help Y.
nnoremap Y y$

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
nnoremap [t :tabp<CR>
nnoremap ]t :tabn<CR>

" clipboard
nnoremap <leader>y "*y
nnoremap <leader>yb V$%y
nnoremap <leader>Y "*y$
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" select pasted text
nnoremap gp `[v`]

" add numbered jumps to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" open current ftplugin file
nnoremap <leader>ef :e ~/.config/nvim/after/ftplugin/<C-R>=&filetype<CR>.vim<CR>

" terminal
tnoremap JK <C-\><C-n>
tnoremap KK <C-\><C-n>G
tnoremap <expr> <A-r> '<C-\><C-n>"' . nr2char(getchar()) . 'pi'
nnoremap <leader>t :ter<cr>

" debug
nnoremap <leader>m :<c-u>ccl \| Messages \| res +20<CR>
nnoremap <leader>lr :<c-u>lua require('lspsetup.utils').reset_config()<CR>
nnoremap <leader>lp :<c-u>lua print(vim.inspect())<left><left>

" vim:sw=2 ts=2 et
