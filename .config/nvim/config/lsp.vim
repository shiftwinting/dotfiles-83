lua require('lspsetup')

" Diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1

" Completion
imap <silent> <c-n> <Plug>(completion_trigger)
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_items_priority = {
            \ 'Field': 11,
            \ 'Property': 7,
            \ 'Function': 7,
            \ 'Variables': 7,
            \ 'Variable': 7,
            \ 'Method': 10,
            \ 'Interfaces': 5,
            \ 'Constant': 5,
            \ 'Class': 5,
            \ 'Keyword': 4,
            \ 'UltiSnips' : 1,
            \ 'vim-vsnip' : 0,
            \ 'Buffer' : 1,
            \ 'Buffers' : 1,
            \ 'TabNine' : 0,
            \ 'File' : 1,
            \ }

let g:completion_chain_complete_list = [
            \ {'complete_items': ['lsp', 'snippet', 'path', 'buffer', 'buffers']},
            \ {'mode': '<c-p>'},
            \ {'mode': '<c-n>'}
            \ ]

" TODO: Add more of this stuff
" Custom implemented or not needed
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ac    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> [g            :<c-u>PrevDiagnosticCycle<CR>
nnoremap <silent> ]g            :<c-u>NextDiagnosticCycle<CR>

" To analyze
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.references()<CR>

" vim:sw=2 ts=2 et
