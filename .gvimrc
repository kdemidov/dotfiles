" Disable beeping and visual beep
set vb t_vb=

" Disable some GUI components
"set guioptions+=m  " Menu
set guioptions-=T  " Toolbar
set guioptions-=l  " Left-hand scrollbar
set guioptions-=L  " Left-hand scrollbar when there is a vertically split window
set guioptions-=r  " Right-hand scrollbar
set guioptions-=R  " Right-hand scrollbar when there is a vertically split window

" Automatically resize splits when resizing MacVim window
autocmd VimResized * wincmd =

set guifont=Menlo\ Regular:h13

" Always show tabs
"set showtabline=2

" Sessions stuff {{{
"set sessionoptions=buffers,curdir,folds,help,options,resize,tabpages,winpos,winsize
set sessionoptions=buffers,curdir,help,resize,tabpages,winpos,winsize
set sessionoptions-=blank

"au VimLeave * mksession! $HOME/.vim/.gvimsession
"au VimEnter * source $HOME/.vim/.gvimsession
"au VimEnter * nested call xolox#session#auto_load()
"au VimLeavePre * call xolox#session#auto_save()
"au VimLeavePre * call xolox#session#auto_unlock()
"au BufEnter * call xolox#session#auto_dirty_check()
" }}}
