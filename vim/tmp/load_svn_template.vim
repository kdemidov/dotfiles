function! LoadCommitTemplate(fpath)
  if a:fpath == '<afile>'
    let l:fpath = expand(a:fpath)
  else
    let l:fpath = a:fpath
  endif

  if filereadable(l:fpath)
    let l:lines = readfile(l:fpath) + getline(1, '$')

    let l:i = 0
    while l:i < len(l:lines)
      call setline(l:i + 1, l:lines[l:i])
      let l:i += 1
    endwhile
  endif
endfunction

function! SaveCommitTemplate(fpath)
  if a:fpath == '<afile>'
    let l:fpath = expand(a:fpath)
  else
    let l:fpath = a:fpath
  endif

  call writefile(getline(1, '$'), l:fpath)
endfunction

let g:tp_commit_template = '/var/www/trialpay/COMMIT'

autocmd filetype svn,*commit* call LoadCommitTemplate(g:tp_commit_template)
autocmd! BufReadPost svn-commit.tmp call LoadCommitTemplate(g:tp_commit_template)
autocmd! BufWritePre svn-commit.tmp call SaveCommitTemplate(g:tp_commit_template)

" Spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell
