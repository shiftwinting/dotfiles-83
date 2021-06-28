augroup cursorLineOnActivePaneOnly
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup removeTraillingSpaces
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup foldMethodMarkerOnVimFiles
  autocmd!
  autocmd FileType vim,zsh setlocal foldmethod=marker sw=2 ts=2 et
augroup END

" left here as example
" augroup OverwriteFoldedHiColor
"   autocmd!
"   autocmd ColorScheme nord highlight Folded guifg=#81A1C1
" augroup END

augroup Dirvish
  autocmd!
  autocmd FileType dirvish nnoremap <buffer> <leader>n :edit %
  autocmd FileType dirvish nnoremap <buffer> <leader>m :!mkdir %
  autocmd FileType dirvish nnoremap <buffer> <leader>t :!touch %
augroup END

augroup Vue
  autocmd!
  autocmd FileType vue setlocal commentstring=\/\/\ %s
augroup END

augroup templates
  autocmd!
  autocmd BufNewFile *.editorconfig 0r ~/.config/nvim/templates/.editorconfig
augroup END

augroup QuickfixBottom
  autocmd!
  autocmd BufWinEnter quickfix norm J
augroup END

augroup CreateFoldersOnSave
  autocmd!
  autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END

augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
augroup END

" Highlight yank
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}

augroup yankRestoreCursor
    autocmd!
    autocmd VimEnter,CursorMoved *
        \ let s:cursor = getpos('.')
    autocmd TextYankPost *
        \ if v:event.operator ==? 'y' |
            \ call setpos('.', s:cursor) |
        \ endif
augroup END

augroup terminalOptions
  au TermOpen * setlocal nonumber norelativenumber
augroup END

au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber

" vim:sw=2 ts=2 et
