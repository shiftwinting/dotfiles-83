setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal colorcolumn=80

nnoremap <leader>rr :T go run %<cr>
nnoremap <leader>tk :Tkill<cr>
nnoremap <leader>tc :Tclear<cr>
nnoremap <leader>rt :T go test<cr>
nnoremap <leader>rb :T go test -bench=.<cr>

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
