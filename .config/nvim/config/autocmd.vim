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

augroup OverwriteFoldedHiColor
  autocmd!
  autocmd ColorScheme nord highlight Folded guifg=#81A1C1
augroup END

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

augroup stayNoLCD
  autocmd!
  autocmd User BufStaySavePre  if haslocaldir() | let w:lcd = getcwd() | cd - | cd - | endif
  autocmd User BufStaySavePost if exists('w:lcd') | execute 'lcd' fnameescape(w:lcd) | unlet w:lcd | endif
augroup END

augroup QuickfixBottom
  autocmd!
  autocmd BufWinEnter quickfix norm J
augroup END

au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" Highlight yank
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}

" Autoread inside vim
au FocusGained,BufEnter * :checktime

au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber
au CmdLineEnter * set norelativenumber | redraw
au CmdlineLeave * set relativenumber

" vim:sw=2 ts=2 et
