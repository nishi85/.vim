augroup AutoMkdir
  autocmd!
  autocmd VimEnter * call s:MakeDirs()
augroup END

function! s:MakeDirs ()
  "" Make important directories if they don't exist
  let dirs = eval(join(map([&bdir,&dir,&udir], 'split(v:val,",")'), '+'))
  let dirs += [&vdir]
  if exists('g:UltiSnipsSnippetsDir')
    let dirs += [g:UltiSnipsSnippetsDir]
  endif
  for dir in dirs
    if empty(finddir(dir))
      call mkdir(dir, 'p')
    endif
  endfor
endfunction
