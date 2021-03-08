lua require('lspsetup')
lua require('baldore.telescope')

" Diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1

" Completion
inoremap <silent><expr> <c-n> compe#complete()

" Custom implemented or not needed
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ac    <cmd>lua vim.lsp.buf.code_action()<CR>

" To analyze
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gr    <cmd>Telescope lsp_references<CR>

" vim:sw=2 ts=2 et
