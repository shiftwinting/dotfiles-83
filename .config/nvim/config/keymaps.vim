" Common
nnoremap <leader>w :w!<CR>
nnoremap ; :
nnoremap : ;
map Q <nop>
nnoremap <C-g> :echo expand('%')<CR>
nnoremap ,<leader> :b #<cr>

" Insert cool stuff
inoremap <C-b> <C-x><C-p>
inoremap <C-CR> <CR><C-o>O
inoremap <C-s> <Esc>:w<cr>
inoremap <C-h> <Left>
inoremap <C-e> <C-o>$;<Esc>
inoremap {<cr> {<cr>}<c-o>O

" Quick init.vim changes
nnoremap <leader>ie :e ~/.config/nvim/config/
nnoremap <leader>ir :so %<cr>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" make n always search forward and N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" :noh for the win!
nnoremap <CR> :noh<CR><CR>

" Fold
nnoremap <leader>z za

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

" Add numbered jumps to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Debug
nnoremap <leader>m :<c-u>ccl \| Messages \| res +20<CR>
nnoremap <leader>lr :<c-u>lua require('lspsetup.utils').reset_config()<CR>
nnoremap <leader>lp :<c-u>lua print(vim.inspect())<left><left>

" vim:sw=2 ts=2 et
