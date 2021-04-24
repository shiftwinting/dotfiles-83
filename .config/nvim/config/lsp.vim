lua require('lspsetup')
lua require('baldore.telescope')

" completion
" lexima config must be here
let g:lexima_no_default_rules = v:true
let g:lexima_ctrlh_as_backspace = 1
call lexima#set_default_rules()

inoremap <silent><expr> <c-n> compe#complete()
inoremap <silent><expr> <CR>  compe#confirm(lexima#expand('<LT>CR>', 'i'))

" nnoremap <silent> gd :Lspsaga preview_definition<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent> K :Lspsaga hover_doc<CR>
" nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
" scroll
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

autocmd CursorHoldI * Lspsaga signature_help


" vim:sw=2 ts=2 et
