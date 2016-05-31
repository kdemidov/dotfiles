" vim: se foldenable foldmethod=marker:
"
" =========================
"    _  __(_)__ _  ________
"  _| |/ / //  ' \/ __/ __/
" (_)___/_//_/_/_/_/  \__/
" ========================="
"
"	Author: Konstantin Demidov <mail@konstantindemidov.com>
"

" General {{{1

" Force vim into a non-vi compatible mode.
set nocompatible

" Vundle setup and bundles {{{2
set runtimepath+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Original repos on GitHub
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-repeat'
Plugin 'ervandew/supertab'
Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-session'
Plugin 'sjl/gundo.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'sickill/vim-pasta'
Plugin 'Raimondi/delimitMate'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'hdima/python-syntax'
Plugin 'duff/vim-scratch'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'jistr/vim-nerdtree-tabs'

"Plugin 'mattn/zencoding-vim'
"Plugin 'mhinz/vim-startify'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-pathogen'

" Plugins from https://github.com/vim-scripts
Plugin 'vim-scripts/YankRing.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'vim-scripts/showmarks--Politz'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'vim-scripts/nextval'
Plugin 'vim-scripts/bufkill.vim'

" Color scemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'nanotech/jellybeans.vim'
Plugin 'sjl/badwolf'
Plugin 'morhetz/gruvbox'
Plugin 'baskerville/bubblegum'
Plugin 'tomasr/molokai'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'acarapetis/vim-github-theme'

call vundle#end()
" 2}}}

" Use UTF-8 as the default buffer encoding
set encoding=utf-8

" For any given OS, prefer its native fileformat for new files
if has("unix")
  set fileformats=unix,dos,mac
elseif has("win32") || has("win64")
  set fileformats=dos,unix,mac
elseif has("mac")
  set fileformats=mac,unix,dos
endif

" Set the character encoding for files
set fileencodings=utf-8,cp1251,koi8-r,ucs-2,cp866

" Enable commands in russian keyboard mapping
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" Give the GUI cursor another color when the language mappings are being used
highlight lCursor guifg=NONE guibg=Cyan

" Enable russian spell checking
"setlocal spell spelllang=ru_yo,en_us

" Size of command/search history
set history=20

" Allow changing buffers without saving
set hidden

" Use system clipboard
set clipboard+=unnamed

" Completion buffers
set complete=.,w,b,u,k,t,i
"            | | | | | | |
"            | | | | | | `-current and included files
"            | | | | | `-tags completion
"            | | | | `-dict
"            | | | `-unloaded buffers
"            | | `-other loaded buffers
"            | `-buffers in other windows
"            `-the current buffer

" Don't give the intro message when starting Vim
set shortmess+=I

" automatically change to the current directory when loading a file
"set autochdir

" When editing a file, always jump to the last cursor position.
" This must be after the uncompress commands.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line ("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

if has("gui_macvim")
  " Use option (alt) as meta key in MacVim
  set macmeta
endif

" 1}}}
" Vim internal help {{{1

autocmd FileType sh,vimwiki,config,none setlocal keywordprg="man"
autocmd FileType vim,help let &keywordprg=":help"

" 1}}}
" Files, Backup, Swap files {{{1

" Remember things between sessions
set viminfo='20,<50,:20,%,h,n$HOME/.vimfiles/.viminfo
"           |   |   |   | |
"           |   |   |   | +----- Don't restore hlsearch on startup
"           |   |   |   +------- Keep the buffer list (if vim started without a file arg)
"           |   |   +----------- Remember N items in command-line history
"           |   +--------------- Save N lines for each register
"           +------------------- Remember marks for N previous files

" Write contents of the file, if it has been modified, on buffer exit
"set autowrite

" Automatically reload the file when modified outside and not modified inside vim
set autoread

" Turn backup off, since most stuff is in SVN, git and etc. anyway
set nobackup
set nowritebackup

" Where to store the swap files
set directory=/tmp//
" Write swap file to disk after every 50 characters
set updatecount=50

" 1}}}
" Persistent undo {{{1
"
if has('persistent_undo')
  " Save undo history to an external file
  set undofile
  " Where to save undo history files
  set undodir=$HOME/.vimfiles/undofiles//,/tmp//
  " Maximum number of changes that can be undone
  set undolevels=1000
  " Maximum number lines to save for undo on a buffer reload
  set undoreload=10000
endif

" 1}}}
" UI {{{1

" Turn syntax highlighting on
syntax on

" Maximum column in which to search for syntax items
set synmaxcol=2048

" Colored column (to see line size violations)
"set colorcolumn=100

" Use the color scheme
if has("gui_running")
  colorscheme jellybeans
  "colorscheme Tomorrow-Night

  hi SignColumn guibg=#101010
  hi hlShowMarks guifg=#eeeeee guibg=#875f87
  "hi cursorline guibg=#333333
else
  " Enable 256 colors for terminal
  set t_Co=256
  colorscheme jellybeans
  "colorscheme Tomorrow-Night
endif

" Enable the mouse for all modes
set mouse=a

" Use better looking listchars if they are supported
if has("multi_byte")
  set listchars=tab:»\ ,extends:›,precedes:‹,trail:·,nbsp:✂,eol:$
else
  set listchars=tab:>\ ,extends:>,precedes:<,trail:-,nbsp:%,eol:$
endif

" Don't display unprintable characters
set nolist

" Settings for :TOhtml
let html_number_lines = 1
let html_use_css = 1
let use_xhtml = 1
" 1}}}
" Text-Formatting, Identing, Tabbing {{{1

" Enable loading filetype and indentation plugins
filetype plugin indent on

set autoindent    " Use indent from previous line
set smarttab      " Smart handling of the tab key
set expandtab     " Use spaces for tabs
set tabstop=2     " Number of spaces that a tab in the file counts for
set shiftwidth=2  " Number of spaces for each (auto)indent
set shiftround    " Round indent to multiple of 'shiftwidth' for > and < commands

set nowrap        " Don't wrap long lines by default
set linebreak     " Break lines at a sensible place
set nojoinspaces  " Only one space will be inserted with a join command

" Allow backspacing over indentation, end-of-line, and start-of-line
set backspace=indent,eol,start

" Enable virtual editing. Cursor can be positioned where there is no actual character
set virtualedit=all

" Enable Ctrl-A/Ctrl-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Don't continue comments when pushing o/O or after hitting <Enter> in Insert mode
set formatoptions-=orc

" Add extra characters that are valid parts of variables
set iskeyword+=\$,-

" Don't go to the start of the line after some commands
set nostartofline

" 1}}}
" Code folding {{{1

" Fold column width
set foldcolumn=1

" Folds are created manually
set foldmethod=manual

" Number of screen lines above which a fold can be displayed closed
set foldminlines=2

" Folds with a higher level will be automatically closed.
set foldlevel=2

" Deepest fold is 3 levels
set foldnestmax=3

" Don't fold by default
set nofoldenable

" 1}}}
" Searching, Substituting {{{1

set incsearch    " Show search matches as you type
set ignorecase   " Ignore case when searching
set smartcase    " Override 'ignorecase' when needed
set hlsearch     " Highlight search results
set showmatch    " Show matching brackets/parenthesis
set matchtime=2  " ... (for only N seconds)
set gdefault     " Assume the /g flag on :s substitutions to replace all matches in a line

" 1}}}
" Menus, Completion {{{1

" Try to adjust insert completions for case
set infercase

set completeopt=longest,menu,menuone
"               |       |    |
"               |       |    +-- Show popup even with one match
"               |       +------- Use popup menu with completions
"               +--------------- Insert longest completion match

" Use menu to show command-line completion
set wildmenu

" Set command-line completion mode:
set wildmode=list:longest,full
"            |            |
"            |            +-- On second <Tab>, complete the next full match and show menu
"            +--------------- On first <Tab>, when more than one match, list all matches and complete
"                             the longest common string

" A file that matches with one of these patterns is ignored when completing file or directory names

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,.hg,.bzr,.git,*.gem,*.exe,*.so,*.dll,*.pyc
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.7z
" Disable temp and backup files
set wildignore+=*.swp,*~,._*
" Disable images
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp

" 1}}}
" Windows, Splits, Tabs, Scrolling {{{1

set splitright       " When splitting vertically, split to the right
set scrolloff=3      " Lines visible above/below cursor when scrolling
set sidescrolloff=3  " Lines visible to the left/right of cursor when scrolling
set tabpagemax=128   " Maximum number of tabs open
set winminheight=0   " Set minimum window size

" 1}}}
" Sounds {{{1

" Disable any beeps or flashes on error
set noerrorbells
set novisualbell
set t_vb=

" 1}}}
" Display, Messages, Terminal {{{1

set lazyredraw  " Don't redraw while executing macros
set ttyfast     " Indicates a fast terminal connection
set vb t_vb=    " Disable beeping and visual bell
set report=0          " Always report the number of lines changed
set display=lastline  " Show as much of the last line as possible

" Do syntax highlighting when printing
set printoptions+=syntax:y

" 1}}}
" Status Line, Messages {{{1

set showcmd       " Show (partial) command in the last line of the screen
set showmode      " Display the current mode in the last line
set number        " Turn line numbering on
set ruler         " Display info on current position
set laststatus=2  " Always show status line

" Nice status line
set statusline=%!GetStatusLine()

" Informative tab labels
set guitablabel=%{GuiTabLabel()}

" 1}}}
" Helper functions {{{1

" Returns the indent level of the current line
function! GetIndent()
  return indent('.') / &sw
endfunction

"function! FileSize()
  "let bytes = getfsize(expand('%:p'))
  "if bytes <= 0
    "return ''
  "endif
  "if bytes < 1024
    "return bytes . 'b';
  "else
    "return (bytes / 1024) . 'k'
  "endif
"endfunction

" Returns the string used for the status line
function! GetStatusLine()
  let line = ''
  let line .= '#%-3.3n '                         " buffer number
  let line .= '%f '                              " file name
  let line .= '%m%r%w'                           " flags
  let line .= "[%{strlen(&ft) ? &ft : 'none'}"   " filetype
  let line .= ' %{&encoding}'                    " encoding

  if (exists('+bomb') && &bomb)
    let line .= ','
    let line .= '%#warningmsg#'
    let line .= 'bom'                            " BOM marker
    let line .= '%*'                             " restore normal highlight
  endif

  let line .= ' %{&fileformat}'                 " file format
  let line .= " %{&expandtab ? 'spaces' : 'tabs'}:%{&tabstop}]"
  "let line .= " [%{&wrap ? 'wrap' : 'nowrap'} "  " line wrap status
  "let line .= "%{&hls ? 'hls' : 'nohls'} "       " hlsearch status
  "let line .= "%{&list ? 'list' : 'nolist'} "    " list status
  "let line .= '%{FileSize()}'
  let line .= '%*'
  let line .= '%='                               " right align
  let line .= '0x%-8B'                           " current char
  let line .= '+%{GetIndent()} '                 " indent level
  let line .= '%-14.(%l,%c%V%) %<%P'             " offset
  return line
endfunction

function! GuiTabLabel()
  " add the tab number
  let label = '[' . tabpagenr()

  " count number of open windows in the tab
  "let wincount = tabpagewinnr(v:lnum, '$')
  "if wincount > 1
    "let label .= ', ' . wincount
  "endif

  let label .= '] '

  let buflist = tabpagebuflist(v:lnum)

  " add the file name without path information
  let fname = bufname(buflist[tabpagewinnr(v:lnum) - 1])
  let label .= (fname != '' ? fnamemodify(fname, ':t') : '[No Name]')

  " modified since the last save?
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')
      let label .= ' +'
      break
    endif
  endfor

  return label
endfunction

" Moves the active tab page to the left (wraps around)
function! MoveTabLeft()
  let n = tabpagenr()
  execute 'tabmove' (n == 1 ? '' : n - 2)
endfunction

" Moves the active tab page to the right (wraps around)
function! MoveTabRight()
  let n = tabpagenr()
  execute 'tabmove' (n == tabpagenr('$') ? 0 : n)
endfunction

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString(string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

" 1}}}
" Plugins configuration {{{1

" NERDTree {{{2

let NERDTreeMinimalUI = 1
let NERDTreeWinSize = 35
let NERDTreeHighlightCursorline = 1
let NERDTreeHijackNetrw = 1
let NERDTreeShowHidden = 1
let NERDTreeBookmarksFile = $HOME . '/.vimfiles/.NERDTreeBookmarks'
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
let NERDTreeDirArrows = 0
" Close Vim if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
  \&& b:NERDTreeType == "primary") | q | endif

" 2}}}
" BufExplorer {{{2

let g:bufExplorerDisableDefaultKeyMapping = 1
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSplitBelow = 1
let g:bufExplorerFindActive = 0
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSplitOutPathName = 0
let g:bufExplorerHorzSize = 20

" 2}}}
" Indent guides {{{2
let g:indent_guides_guide_size = &shiftwidth
let g:indent_guides_auto_colors = 0
" 2}}}
" Session.vim {{{2

let g:session_directory = $HOME . '/.vimfiles/sessions'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_default_to_last = 'yes'
"let g:session_command_aliases = 1

" 2}}}
" Gundo {{{2

let g:gundo_right = 1
let g:gundo_auto_preview = 1
let gundo_tree_statusline = 'Gundo tree'
let gundo_preview_statusline = 'Gundo preview'

" 2}}}
" YankRing {{{2

" skip all single-letter deletes (x)
let g:yankring_min_element_length = 2

" save last 50 items in history, only show last 50 in yankring window
let g:yankring_max_history = 50
let g:yankring_max_display = 50

" save yankring entries across vim instances
let g:yankring_persist = 1
let g:yankring_share_between_instances = 1

" don't save duplicates
let g:yankring_ignore_duplicate = 1

" use a separate vertical split window that auto closes and is 30 chars wide on
" the right side
let g:yankring_window_use_separate = 1
let g:yankring_window_use_horiz = 0
let g:yankring_window_auto_close = 1
let g:yankring_window_width = 30
let g:yankring_window_use_right = 1

" pressing <space> will increase the size of the window by 15 columns
let g:yankring_window_increment = 15

" have yankring manage Vim's numbered registers ("0-"9)
let g:yankring_manage_numbered_reg = 1

" keep the history file in the following folder rather than $HOME
let g:yankring_history_dir = $HOME . '/.vimfiles'

" name of the history file
let g:yankring_history_file = '.yankring_history'

" yankring keeps an eye on the clipboard
let g:yankring_clipboard_monitor = 1

" if something changes the default register without going through yankring, use
" the default register value rather than the top item in yankring's history
let g:yankring_paste_check_default_buffer = 1

" 2}}}
" Other plugins {{{2

" SnipMate
let g:snippets_dir = $HOME . '/.vim/bundle/snipmate-snippets/'

" ShowMarks
let g:showmarks_marks = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" matchit
let b:match_ignorecase = 1
" 2}}}
" 1}}}
" Mappings {{{1

" Leader mappings {{{2
" Set the <Leader> for combo commands
let mapleader=";"

 " Toggle pattern highlighting
"noremap <silent><leader>/ :setlocal hls!<Bar>setlocal hls?<CR>
noremap <silent><leader>/ :nohlsearch<CR>

" Change to directory of file
noremap <silent> <Leader>cd :cd %:h<CR>

" Quickly switch to last buffer
nnoremap <leader>, :e#<CR>

" Underline the current line with '-'
nnoremap <silent> <leader>ul :t.\|s/./-/\|:nohls<cr>

" Underline the current line with '='
nnoremap <silent> <leader>uul :t.\|s/./=/\|:nohls<cr>

" Surround the commented line with lines.
"
" Example:
"          # Test 123
"          becomes
"          # --------
"          # Test 123
"          # --------
nnoremap <silent> <leader>cul :normal "lyy"lpwv$r-^"lyyk"lP<cr>

" Format the entire file
"nnoremap <leader>fef mx=ggG='x

" Create a new empty tab
noremap <silent> <Leader>tn :tabnew<CR>

" Rename the current file
noremap <Leader>fr :call RenameFile()<CR>

" Rename the current file
noremap <Leader>gu :GundoToggle<CR>

" Shortcuts for session management
noremap <leader>ss :wa<CR>:SessionSave<CR>
noremap <leader>sc :wa<CR>:SessionClose<CR>
noremap <leader>so :wa<CR>:SessionOpen<CR>

" Save changes
noremap <silent> <Leader>w :w<CR>

" Exit without saving any changes
noremap <silent> <Leader>q :q!<CR>

" Save changes and exit
noremap <silent> <Leader>x :x<CR>

" Quicker way to delete a buffer
nnoremap <Leader>bd :bd<CR>

" Delete all buffers
nnoremap <silent> <Leader>bda :exec '1,' . bufnr('$') . 'bd'<CR>

" Useful newline bindings for normal mode
nnoremap <Leader>O O<Esc><Down>
nnoremap <Leader>o o<Esc><Up>
"noremap <S-ENTER> O<ESC>j
"noremap <ENTER> o<ESC>k
"nnoremap go o<Esc>k
"nnoremap gO O<Esc>j

" Insert a single char
noremap <Leader>i i<Space><Esc>r

" Find and replace selected text across the entire file
vmap <Leader>r <Esc>:%s/<c-r>=GetVisual()<cr>/

" Remove all trailing spaces
nnoremap <silent> <Leader>ws :%s/\s\+$//<CR>:let @/=''<CR>

" Toggle NERDTree window
nnoremap <Leader>nt :NERDTreeToggle<CR>

" Find the current file in the tree
nnoremap <Leader>nf :NERDTreeFind<CR>

" Open BufExplorer
nnoremap <Leader>be :BufExplorer<CR>

" Fast open/reload vimrc
nnoremap <Leader>ev :split $MYVIMRC<CR>
" TODO: Show ".vimrc is reloaded." massage.
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Shortcut for reloading snippets, useful when developing
"nnoremap <Leader>snr <Esc>:exec ReloadAllSnippets()<CR>

" Wrap visual selections with chars
vnoremap <buffer> ( "zdi(<C-R>z)<ESC>
vnoremap <buffer> { "zdi{<C-R>z}<ESC>
vnoremap <buffer> [ "zdi[<C-R>z]<ESC>
vnoremap <buffer> ' "zdi'<C-R>z'<ESC>

" 2}}}


" Highlight search word under cursor without jumping to next
nnoremap * *<C-O>

" Use ; for : in normal and visual mode, less keystrokes
"nnoremap ; :
"vnoremap ; :

" Toggle fold under cursor
nnoremap <Space> za

" Create fold from visually selected text
vnoremap <Space> zf

" By default search with 'very nomagic'
nnoremap / /\V

" Moving and resizing in windows.
nnoremap + <C-W>+
nnoremap _ <C-W>-

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Moving around in insert mode
inoremap <A-j> <C-O>gj
inoremap <A-k> <C-O>gk
inoremap <A-h> <Left>
inoremap <A-l> <Right>

if has("gui_macvim")
  " Use Cmd+Shift+Left and Cmd+Shift+Right to switch between tabs
  map <D-S-Right> gt
  map <D-S-Left> gT
endif

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"map <silent> <C-S-PageUp> :call MoveTabLeft()<CR>
"map <silent> <C-S-PageDown> :call MoveTabRight()<CR>
"map <silent> <Tab> :call MoveTabLeft()<CR>
"map <silent> <S-Tab> :call MoveTabRight()<CR>
"map <silent> <C-H> :call MoveTabLeft()<CR>
"map <silent> <C-L> :call MoveTabRight()<CR>

" Remap U to <C-r> for easier redo (from http://vimbits.com/bits/356)
nnoremap U <C-r>

" Have Y behave analogously to D and C rather than to dd and cc (which is already done by yy)
noremap Y y$

" Yank entire buffer with gy
"nnoremap gy :%y+<cr>

" Select entire buffer
"nnoremap vy ggVG

" Allows writing to files with root privledges
cnoremap w!! %!sudo tee > /dev/null %

" Press {{, ((, [[, << and it will insert the corresponding }, ), ] ot >
"inoremap {{ {<CR>}<Esc>kA<CR>
"inoremap (( ()<Esc>i
"inoremap [[ []<Esc>i
"inoremap << <><Esc>i
inoremap <expr> <CR> delimitMate#WithinEmptyPair() ?
         \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
         \ "\<CR>"

" Windows like movements for long lines with wrap enabled
noremap j gj
noremap k gk

noremap 0 ^

" Just to beginning and end of lines easier ( http://vimbits.com/bits/16)
"noremap H ^
"noremap L $

" Easier Scrolling (think j/k with left hand)
"nnoremap <C-j> 15gjzz
"nnoremap <C-k> 15gkzz
"vnoremap <C-j> 15gjzz
"vnoremap <C-k> 15gkzz

" Make line completion easier
"inoremap <C-l> <C-x><C-l>

" Toggle line wrap
map <silent> <F2> :set wrap!<Bar>set wrap?<CR>

" Toggle list mode
map <silent> <F4> :set list!<Bar>set list?<CR>

" Visually show/hide the location of marks
map <silent> <F5> :DoShowMarks!<CR>
map <silent> <F6> :NoShowMarks!<CR>

" Toggle 'paste' mode so one can paste text into the terminal
" without vim messing the text indenting up.
"map <F10> :set paste!<Bar>set paste?<CR>
" TODO: This should be tested.
map <Leader>p :set paste<CR>o<ESC>"*]p:set nopaste<CR>

" allow command line editing like emacs
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <End>
cnoremap <C-P> <Up>

" Disable the ever-annoying Ex mode shortcut key.
" Instead, make Q repeat the last macro (http://vimbits.com/bits/263).
nnoremap Q @@

" 1}}}
" Auto Commands {{{1
if has("autocmd")
  augroup MyAutoCommands
    " Highlight current line in insert mode.
    autocmd InsertLeave * se nocursorline
    autocmd InsertEnter * se cursorline

    " Help mode bindings: <enter> to follow tag, <bs> to go back, and q to quit
    autocmd filetype help nnoremap <buffer><cr> <c-]>
    autocmd filetype help nnoremap <buffer><bs> <c-T>
    autocmd filetype help nnoremap <buffer>q :q<CR>

    "autocmd BufWritePost *
    "\ if getline(1) =~ "^#!" |
    "\   if getline(1) =~ "/bin/" |
    "\     silent !chmod a+x <afile> |
    "\   endif |
    "\ endif
  augroup END
endif
" 1}}}

if filereadable($HOME . "/.vimrc_extra")
  source $HOME/.vimrc_extra
endif
