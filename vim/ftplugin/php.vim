" Line width
setlocal textwidth=79

set formatoptions=qrocb

" Make folding indent sensitive
set foldmethod=indent

" All folds are open
set nofoldenable

" Use php syntax check when doing :make
"setlocal makeprg=php\ -l\ %

" Use errorformat for parsing PHP error output
"setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Dictionary completion
"setlocal dictionary+=$HOME/.vim/misc/php/funclist.txt

" Indent 'case:' and 'default:' statements in switch() blocks
let g:PHP_vintage_case_default_indent = 1
