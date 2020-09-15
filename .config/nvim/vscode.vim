" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'

call plug#end()
" }}}

let mapleader=" "

nnoremap <leader>w :Write<CR>

" Keymaps
nnoremap ; :
nnoremap : ;

nnoremap <c-p> :Edit<CR>
nnoremap <CR> :noh<CR><CR>

" Comments
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Git
nnoremap [h :call VSCodeCall('workbench.action.editor.previousChange')<cr>
nnoremap ]h :call VSCodeCall('workbench.action.editor.nextChange')<cr>
nnoremap <leader>gs :call VSCodeCall('git.openChange')<cr>
" nnoremap [h :call VSCodeCall('workbench.action.compareEditor.previousChange')<cr>
" nnoremap ]h :call VSCodeCall('workbench.action.compareEditor.nextChange')<cr>

" Problems
nnoremap [g :call VSCodeCall('editor.action.marker.prevInFiles')<cr>
nnoremap ]g :call VSCodeCall('editor.action.marker.nextInFiles')<cr>

" Search
nnoremap [q :call VSCodeCall('search.action.focusPreviousSearchResult')<cr>
nnoremap ]q :call VSCodeCall('search.action.focusNextSearchResult')<cr>
