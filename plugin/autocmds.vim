"" Automatically source vim files when written
augroup AutoSource
  autocmd!
  autocmd BufWritePost init.vim,*/{autoload,plugin}/*.vim silent! call s:Source(expand('<afile>'))
augroup END

function! s:Source (file)
  let file = fnamemodify(resolve(resolve(a:file)), ':p')
  if filereadable(file)
    exe 'source' file
  endif
endfunction

function! s:AutoMake (file)
  if file_readable(a:file) && !empty(getbufvar(a:file, '&l:makeprg'))
    exe 'silent! lmake!' fnamemodify(a:file, ':S')
  endif
endfunction

augroup MyAutocmds
  au!
  au BufWritePre,FileWritePre ?*
    \ if expand('<afile>') !~? '^[a-z0-9]\+:\/\/' |
        \ silent! call mkdir(expand('<afile>:h'), 'p') |
    \ endif
  au BufWritePre * let &bex=strftime(".%F.%T.vimbackup")
  au BufAdd ?*.* exe 'set sua+=.'.expand('<amatch>:e')
  au VimResized * wincmd =
  au CmdWinEnter * setlocal nonumber
  au BufWinEnter * if &previewwindow | set winfixwidth winfixheight | endif
  au BufUnload ?* silent! mkview!
  au BufWinEnter ?* silent! loadview
  autocmd ColorScheme * hi! link SignColumn FoldColumn
  autocmd ColorScheme * silent! exe 'runtime! after/colors/' . expand('<amatch>') . '.vim'
  " autocmd BufWritePost * call s:AutoMake(expand('<afile>:p'))

  "" I REALLY fucking hate eclim
  " au BufWinEnter * autocmd! eclim_refresh_files
augroup END
