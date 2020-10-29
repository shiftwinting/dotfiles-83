source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/lsp.vim
source $HOME/.config/nvim/config/pluginsconf.vim
source $HOME/.config/nvim/config/keymaps.vim
source $HOME/.config/nvim/config/autocmd.vim

" Utils {{{
function! OpenPluginDocs()
    let github_path = 'https://github.com/'
    let quotes_text_regex = '\v([''"])(.{-})\1'
    let currentline = trim(getline('.'))

    if matchstr(currentline, '^Plug') == ''
        throw "Current line doesn't match plugin pattern."
    endif

    let plugin_path = matchstr(currentline, quotes_text_regex)[1:-2]
    call system('open ' . github_path . plugin_path)
endfunction

command OpenPluginDocs :call OpenPluginDocs()

function! ShowHighlightGroups()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nnoremap <leader>hg :call ShowHighlightGroups()<cr>
" }}}

