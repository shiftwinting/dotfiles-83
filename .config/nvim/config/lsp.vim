lua require('lspsetup')

" Diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1

" Completion
imap <silent> <c-n> <Plug>(completion_trigger)
let g:completion_sorting = 'length'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_items_priority = {
            \ 'EnumMember': 11,
            \ 'Field': 11,
            \ 'Constant': 11,
            \ 'Variables': 11,
            \ 'Property': 7,
            \ 'Function': 7,
            \ 'Variable': 7,
            \ 'Method': 10,
            \ 'Interfaces': 5,
            \ 'Class': 5,
            \ 'Keyword': 4,
            \ 'UltiSnips' : 1,
            \ 'File' : 1,
            \ }

let g:completion_chain_complete_list = [
            \ {'complete_items': ['lsp', 'snippet', 'path']},
            \ {'mode': '<c-p>'},
            \ {'mode': '<c-n>'}
            \ ]

" TODO: Add more of this stuff
" Custom implemented or not needed
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ac    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> [g            <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]g            <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" To analyze
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.references()<CR>

" vim:sw=2 ts=2 et
