" Fzf {{{
let g:fzf_history_dir = '~/.config/nvim/fzf-history'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Maps
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :BLines<CR>
nnoremap <silent> <leader>fc :History:<CR>
nnoremap <silent> <leader>s :Snippets<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>rg :Rg!<CR>
nnoremap <silent> <leader>* :Rg! <C-R><C-W><CR>
vnoremap <silent> <leader>* y:Rg! <C-r>0<CR>
cnoremap <C-e> <C-c>:Commands<CR>
inoremap <C-l> <C-o>:Snippets<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

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

" Vimwiki {{{
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
" Fix issue with tab for snippets
let g:vimwiki_key_mappings =
      \ {
      \ 'headers': 0,
      \ }
let g:vimwiki_table_mappings = 0
let g:vimwiki_auto_chdir = 1
" }}}

" IndentLine {{{
let g:indentLine_concealcursor = 'ic'
let g:indentLine_conceallevel = 2
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
nnoremap <leader>gb :Gblame<cr>
" }}}

" incsearch {{{
let g:asterisk#keeppos = 1

cmap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<C-g>" : "<C-Z>"
cmap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<C-t>" : "<S-Tab>"

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

" Yank Highlight {{{
let g:highlightedyank_highlight_duration = 400
"}}}

" Vim Asterisk {{{
map *  <Plug>(asterisk-z*)
"}}}

" vim-sandwich {{{
runtime macros/sandwich/keymap/surround.vim
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsSnippetDirectories=["own_snippets"]

nnoremap <space>ee :UltiSnipsEdit<CR>
" }}}

" ALE {{{
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'typescript': ['eslint'],
      \   'typescriptreact': ['eslint'],
      \}
let g:ale_fixers = {
      \   'vue': ['eslint'],
      \   'html': ['prettier'],
      \   'javascript': ['eslint'],
      \   'typescript': ['eslint'],
      \   'typescriptreact': ['eslint'],
      \   'python': ['black'],
      \   'go': ['goimports'],
      \   'dart': ['dartfmt'],
      \   'rust': ['rustfmt'],
      \}
let g:ale_fix_on_save = 1
let g:ale_hover_to_preview = 1
let g:ale_set_loclist = 0

" Custom Highlights
hi ALEError gui=underline

nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>

" }}}

" Lightline {{{
let g:lightline = {
      \  'colorscheme': 'tender',
      \  'active': {
      \    'left':  [ [ 'mode', 'paste' ], [ 'readonly', 'filenameOrLastFolderOfIndex', 'modified' ] ],
      \    'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ] ]
      \  },
      \  'component_function': {
      \    'gitbranch': 'fugitive#head',
      \    'filenameOrLastFolderOfIndex': 'LightLineFixIndexFiles'
      \  },
      \  'mode_map': {
      \    'n' : 'N',
      \    'i' : 'I',
      \    'R' : 'R',
      \    'v' : 'V',
      \    'V' : 'VL',
      \    "\<C-v>": 'VB',
      \    'c' : 'C',
      \    's' : 'S',
      \    'S' : 'S',
      \    "\<C-s>": 'SB',
      \    't': 'T',
      \  }
      \ }

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

" Floaterm {{{
let g:floaterm_autoclose = 1

nnoremap <leader>gl :<C-u>FloatermNew lazygit<CR>

command Conf FloatermNew lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME
" }}}

" vim:sw=2 ts=2 et
