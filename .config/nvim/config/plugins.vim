" LSP {{{
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
nnoremap <silent> gD <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent> K :Lspsaga hover_doc<CR>
" nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <silent> <leader>ca :Lspsaga code_action<CR>
vnoremap <silent> <leader>ca :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
" scroll
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

autocmd CursorHoldI * Lspsaga signature_help

" }}}

" Fzf + Telescope {{{

let g:fzf_history_dir = '~/.config/nvim/fzf-history'
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'none' } }

" Maps
nnoremap <silent> <C-p> :Files<cr>
nnoremap <silent> <leader><leader> :Files<cr>
nnoremap <silent> <leader>. :exec 'Files ' . getcwd() . '/' . expand('%:h')<cr>
" nnoremap <silent> <leader>sb :lua require('baldore.telescope').buffer_lines()<cr>
nnoremap <silent> <leader>sb :BLines<cr>
nnoremap <silent> <leader>sc :History:<cr>
nnoremap <silent> <leader>ss :Telescope ultisnips<cr>
nnoremap <silent> <leader>bb :Buffers<cr>
nnoremap <silent> <leader>fr :History<cr>
" nnoremap <silent> <leader>t :BTags<cr>
nnoremap <silent> <leader>rg :Rg!<cr>
nnoremap <silent> <leader>* :Rg! <C-R><C-W><cr>
vnoremap <silent> <leader>* y:Rg! <C-r>0<cr>
cnoremap <C-e> <C-c>:Commands<cr>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

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

nnoremap ]g :GitGutterNextHunk<cr>
nnoremap [g :GitGutterPrevHunk<cr>

nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)

" }}}

" Emmet {{{
let g:user_emmet_settings = {
      \  'javascript' : {
      \      'extends' : 'jsx',
      \  },
      \}
let g:user_emmet_expandabbr_key = '<C-y><Space>'
" }}}

" Tmux nav {{{
let g:tmux_navigator_save_on_switch = 1
" }}}

" IndentLine {{{
let g:indentLine_concealcursor = 'ic'
let g:indentLine_conceallevel = 2
" }}}

" Fugitive {{{
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gb :Git blame<cr>
" }}}

" incsearch {{{
let g:asterisk#keeppos = 1
" }}}

" MatchTagAlways {{{
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'javascript' : 1,
      \}
" }}}

" Tagalong {{{
let g:tagalong_additional_filetypes = ['javascript']
" }}}

" Test {{{
let test#strategy = "neovim"
" }}}

" Vim Asterisk {{{
map *  <Plug>(asterisk-z*)
"}}}

" vim-sandwich {{{
runtime macros/sandwich/keymap/surround.vim
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsSnippetDirectories=["own_snippets"]

nnoremap <space>ee :UltiSnipsEdit<cr>
" }}}

" ALE {{{
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'javascriptreact': ['eslint'],
      \   'typescript': ['eslint'],
      \   'typescriptreact': ['eslint'],
      \   'go': ['golangci-lint'],
      \}

" \   'html': ['prettier'],
let g:ale_fixers = {
      \   'vue': ['eslint'],
      \   'typescript': ['eslint'],
      \   'typescriptreact': ['eslint'],
      \   'javascript': ['eslint'],
      \   'javascriptreact': ['eslint'],
      \   'python': ['black'],
      \   'go': ['goimports'],
      \   'dart': ['dartfmt'],
      \   'rust': ['rustfmt'],
      \   'css': ['prettier'],
      \}
let g:ale_fix_on_save = 1
let g:ale_hover_to_preview = 1
let g:ale_set_loclist = 0

" Custom Highlights
hi ALEError gui=underline

nnoremap ]a :ALENext<cr>
nnoremap [a :ALEPrevious<cr>

" }}}

" Lightline {{{
let g:lightline = {
      \  'tab_component_function': {
      \    'cwdtail': 'GetCWDTail'
      \  },
      \  'tab': {
      \     'active': [ 'cwdtail', 'modified' ],
      \     'inactive': [ 'cwdtail', 'modified' ]
      \   }
      \ }

function! GetCWDTail(n) abort
  return fnamemodify(getcwd(tabpagewinnr(a:n), a:n), ':t')
endfunction

function! LightLineFixIndexFiles()
  let filenameonly = split(expand('%:t:r'), '\.')

  if !len(filenameonly)
    return ''
  endif

  if filenameonly[0] ==? 'index'
    return remove(split(expand('%:h'), '/'), -1) . '/' . expand('%:t')
  else
    return expand('%:t')
  endif
endfunction
" }}}

" Markdown Preview {{{
let g:mkdp_auto_close = 0
" }}}

" Illuminate {{{
highlight LspIlluminate gui=underline

hi def link LspReferenceText LspIlluminate
hi def link LspReferenceWrite LspIlluminate
hi def link LspReferenceRead LspIlluminate

nnoremap [d <cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>
nnoremap ]d <cmd>lua require"illuminate".next_reference{jrap=true}<cr>
" }}}

" Tmux navigator {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" }}}

" Vim Sneak + EasyMotion {{{
let g:sneak#label = 0
let g:sneak#s_next = 1

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

let g:EasyMotion_do_mapping = 0
nmap <c-j> <Plug>(easymotion-overwin-f2)

" }}}

" Explainshell {{{
" ❯ docker container run --name explainshell --restart always -p 5000:5000 -d spaceinvaderone/explainshell
let $EXPLAINSHELL_ENDPOINT = "http://localhost:5000"
" }}}

" bbye {{{
nnoremap <Leader>q :Bdelete<CR>
" }}}

" Neoterm {{{
let g:neoterm_term_per_tab = 1

nnoremap <leader>tk :Tkill<cr>
nnoremap <leader>tc :Tclear<cr>
nnoremap <leader>tp :T<Up>
" }}}

" Maximizer {{{
nnoremap <silent> <leader>wm :MaximizerToggle<cr>
" }}}
