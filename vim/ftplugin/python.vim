setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal smarttab
setlocal expandtab

set foldmethod=indent

 " More syntax highlighting.
"let python_highlight_space_errors = 0
let python_highlight_all = 1

nnoremap <silent> <Leader>py :!python %<CR>
