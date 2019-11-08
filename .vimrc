set nocompatible              " use Vim instead of Vi
filetype on " make vim try to detect file types and load plugins for them

" ---------------------- PLUGIN CONFIGURATION ----------------------
"****************  Launch vim and run :PluginInstall  **************
" initiate Vundle
let &runtimepath.=',$HOME/.vim/bundle/Vundle.vim'
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" start plugin defintion
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'othree/html5.vim'
Plugin 'vim-scripts/L9'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
"Plugin 'vim-scripts/FuzzyFinder'
"Plugin 'itchyny/lightline.vim'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'joonty/vdebug'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/searchfold.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'osyo-manga/vim-anzu'

" -- Web Development
Plugin 'Shutnik/jshint2.vim'
"Plugin 'mattn/emmet-vim'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
"Plugin 'digitaltoad/vim-jade'

" Language specific
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-markdown'
"Plugin 'jnwhiteh/vim-golang'
Plugin 'exu/pgsql.vim'
"Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim'
"Plugin 'fatih/vim-go'
"Plugin 'astoshov/vim-ruby-debugger'
Plugin 'tacahiroy/ctrlp-funky'
"Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'

" Colorschemes
Plugin 'sickill/vim-monokai'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'shawncplus/skittles_berry'

" end plugin definition
call vundle#end()            " required for vundle
" /---------------------- PLUGIN CONFIGURATION ----------------------

set tags= "/home/csebryam/ld-api/tags";

"-------------------------Auto Reload .vimrc-------------------------

augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
"/-------------------------fix vimairline to go faster -------------------------

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

set lazyredraw

"--------------------------Cursor Change color or symbol--------------
"
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif


if &term =~ '^xterm\\|rxvt'
  " solid underscore
  let &t_SI .= '\<Esc>[4 q'
  " solid block
  let &t_EI .= '\<Esc>[2 q'
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif
"/-------------------------Cursor Change color or symbol--------------
"Ruby Auto complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
let g:ycm_collect_identifiers_from_tags_files = 1

autocmd FileType ruby compiler ruby

"au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS

let g:EclimCompletionMethod = 'omnifunc'
set omnifunc =syntaxcomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set , as mapleader
let mapleader = ","

" Show all open buffers and their status
nnoremap <Leader>l :ls<CR>

" Move to the next buffer
"nmap <leader>g :bnext<CR> --old
"map <C-L> :bnext<CR> --old
nmap <TAB> :bnext<CR>

" Move to the previous buffer
"nnoremap <C-H> :bprevious<CR> --old
"nmap <S-TAB> :bprevious<CR> --old
nmap <Leader><TAB> :bprevious<CR>

" last recent buffer
nnoremap <Leader>gg :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
"nmap <leader>dd :bp <BAR> :bd #!<CR> --old
nnoremap <leader>d :bp\|bd #<CR>

" map FuzzyFinder
" noremap <leader>b :FufBuffer<cr>
" noremap <leader>f :FufFile<cr>
" noremap <leader>ls :FufDir<cr>

" dont't unload buffers when they are abandoned, instead stay in the
" background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

"modify a file with read only
set modifiable

"****************************
"WILDMENU********************
"****************************

"Press F7 will show a menu to complete buffer names
set wildcharm=<C-Z>
nnoremap <F7> :b <C-Z>

"will show menu to complete buffers
"set wildchar=<Tab> wildmenu wildmode=list:longest,full
" Wildmenu
if has("wildmenu")
  set wildmode=list:longest
  set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
  set wildignore+=*.a,*.o,*.obj,*~ "stuff to ignore when tab completing
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*DS_Store*
  set wildignore+=*~,*.swp,*.tmp
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip              " MacOSX/Linux
  set wildmode=longest,list
  set wildignore+=*.a,*.o
  set wildignore+=*/node_modules/*,*/bower_components/* " Node.js
  set wildignore+=*/vendor/*,*/dist/*,/target/*         " Meh
  set wildignore+=*/Godeps/*                            " Go
  set wildignore+=*vim/backups*
  set wildignore+=*sass-cache*
  set wildignore+=vendor/rails/**
  set wildignore+=vendor/cache/**
  set wildignore+=*.gem
  set wildignore+=log/**
  set wildignore+=tmp/**
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Automatically Display count of search results
let s:prevcountcache=[[], 0]
function! ShowCount()
  let key=[@/, b:changedtick]
  if s:prevcountcache[0]==#key
    return s:prevcountcache[1]
  endif
  let s:prevcountcache[0]=key
  let s:prevcountcache[1]=0
  let pos=getpos('.')
  try
    redir => subscount
    silent %s///gne
    redir END
    let result=matchstr(subscount, '\d\+')
    let s:prevcountcache[1]=result
    return result
  finally
    call setpos('.', pos)
  endtry
endfunction

"shows line number and column"
set ruler

"better ruler format"
set rulerformat=%l\:%c

" It's useful to show the buffer number in the status line.
set laststatus=2

let &statusline='%{ShowCount()} %<%f %h%m%r%=%-14.(%l,%c%V%) %P'

"List previous vim commands
" nnoremap : q:i
" nnoremap / q/i
" nnoremap ? q?i

"80 character limit
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

colorscheme monokai " Color Scheme
set nu " Set line numbers
"set relativenumber

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" save up to 100 marks, enable capital marks
set viminfo='100,f1

"select all occurences of a word using a keyboard
nnoremap <silent> <leader>ss :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

"select all occurences of a word using a mouse
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
":map <2-LeftMouse> *
:imap <2-LeftMouse> <c-o>*

"Full control of mouse
set mouse=a

"auto reload vim when file changes"
set autoread

"center screen on current line with space
nnoremap <space> zz

" Fast scrolling
set ttyfast

"vim scrollbar
au VimEnter * if line('$') > &lines | set go+=r | else | set go-=r | endif
au VimResized * if line('$') > &lines | set go+=r | else | set go-=r | endif

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Resize splits when the window is resized
au VimResized * :wincmd =

" Save, yo
nnoremap <cr> :w<cr>

" Better command keys
nnoremap ; :

" Ruby hashrocket madness
nnoremap <leader>rh :%s/:\(\w*\)\s*=>\s*/\1: /gc<cr>

" Ruby hashrocket madness
vmap <F2> !format_hash.rb <CR>

" Split down and right
set splitbelow
set splitright

" windows like clipboard
" yank to and paste from the clipboard without prepending "* to commands
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
set clipboard+=unnamedplus  " use the clipboards of vim and win
"set paste breaks plugins               " Paste from a windows or from vim
"set go+=a               " Visual selection automatically copied to the clipboard


" copy and paste
" map c-x and c-v to work as they do in windows, only in insert mode
vm <c-x> "+x
vm <c-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
cno <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']

"yank and paste in same line after character
nnoremap <leader>p <esc>pkJ


" suggestion for normal mode commands
set wildmode=list:longest

"------------Popup auto complete menu
" pop up menu complete
"set completeopt=longest,menuone

"Make Enter work to select a option
"not working
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



" set Adobe's Source Code Pro font as default
set guifont=Source\ Code\ Pro

" allow Tab and Shift+Tab to
" tab  selection in visual mode
"vmap <Tab> >gv
"vmap <S-Tab> <gv

" save with ctrl+s
nmap <c-s> :w<CR> nmap
imap <c-s> <Esc>:w<CR>a

"exit visual mode with ctlr-c
vnoremap <C-c> <Esc>

" ------------------Turn off Swap Files------------------------------
set noswapfile
"set nobackup
set nowb

" ------------------------Scrolling------------------------------
set scrolloff=3 " keep the cursor visible within 3 lines when scrolling
set sidescrolloff=15
set sidescroll =1

"select all of one word
nnoremap <Leader>cs :%s/\<<C-r><C-w>\>/

"Replace all of one word
nnoremap <Leader>c :%s/\<<C-r><C-w>\>//g<Left><Left>


"--------------------------Search-----------------------------
set smartcase " When searching try to be smart about cases
set hlsearch " Highlight search results
set incsearch " Makes search act like search in other modern browsers
set ignorecase " Ignore case when searching

"This unsets the last search pattern register by hitting return -- unselects search
nnoremap <CR> :noh<CR><CR>
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=1

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"--------------------------Folds-----------------------------

" Use space to toggle folds in normal mode
nnoremap <silent> <leader><Space> za

" Create a fold using space in visual mode
vnoremap <silent> <Space> zf"
set foldmethod=manual   "fold based on manual
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" load view for fold
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other cool stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autochdir "Always switch to current file directory

" History/Undo settings
set history=1000
set undofile
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

""set spell "spell checking on
set showmode "display the current mode

set cursorline! "Highlight current line
" :hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white
"highlight CursorLine  term=underline  guibg=#555555  cterm=underline
"hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow
"my last one with colorscheme torte
"hi CursorLine term=bold cterm=bold ctermbg=LightMagenta guibg=Grey40
"---hi CursorLine term=bold cterm=bold guibg=Grey40
"hi CursorLine ctermfg=White ctermbg=Yellow cterm=bold guibg=yellow gui=bold

"highlight when in visual mode
"--hi Visual  guifg=#000000 guibg=#FFFFFF gui=none
"hi Visual  guifg=White guibg=LightBlue gui=none

":hi Pmenu ctermbg=brown ctermfg=darkblue  "for vim
":hi Pmenu guibg=brown ctermfg=darkblue  "for gvim

function! s:SetHighlightings()
  highlight Pmenu ctermbg=brown ctermfg=White
  highlight PmenuSel ctermbg=LightBlue ctermfg=White
  highlight Pmenu guibg=gray10 guifg=LightSteelBlue4
  highlight PmenuSel guibg=gray10 guifg=LightSteelBlue1
endfunction
call s:SetHighlightings()
autocmd ColorScheme * call <SID>SetHighlightings()


set linespace=0 "No extra space between rows
set matchpairs+=<:> "Match, to be used with %
set pastetoggle=<F10> "when pasting over SSH it's a pain to type :set paste and :set nopaste

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
filetype indent on

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set smarttab        " Be smart when using tabs ;)
set shiftwidth=4    " when reading, tabs are 2 spaces
set softtabstop=4   " in insert mode, tabs are 2 spaces, let backspace delete indents

set backspace=indent,eol,start "Backspace for dummies
set ai "Auto indent
set si "Smart indent

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" when moving between searches, center the selected line
nnoremap n nzz
nnoremap N Nzz

" Display tabs and trailing spaces visually, use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬,trail:˺,nbsp:█
"set list listchars=tab:\ \ ,trail:· "my old setting

"Automatically remove trailing spaces"
autocmd FileType c,cpp,java,php,js,rb,py autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Tab Movements
nnoremap <C-h> gT
nnoremap <C-l> gt

"Wrap lines
set nowrap
set linebreak
set nolist

"wrapped lines go down/up to next row, rather than next line in file
nnoremap j gj
nnoremap k gk
" nnoremap $ g$
" nnoremap ^ g^
" nnoremap 0 g0

"stop wrapping lines
set formatoptions-=t

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Do the splits
noremap <Leader>s :split<CR>
noremap <Leader>v :vsplit<CR>


" Status line
set laststatus=2

"-------------------Airline------------------------------
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme="tomorrow"
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_section_c = '%t'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnametruncate = 0

"------------------Gitgutter----------------------------
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

"---------------vim fugitive(git) plugin---------------------
autocmd QuickFixCmdPost *grep* cwindow
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>gt :Gcommit -v -q %:p<CR>
"nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gp :Ggrep<Space>
nnoremap <Leader>gm :Gmove<Space>
"nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
nnoremap <Leader>gps :Dispatch! git push<CR>
nnoremap <Leader>gpl :Dispatch! git pull<CR>

"---------------Ack plugin---------------------
"let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" nmap <leader>a <Esc>:Ack!
" "nnoremap <Leader>a :Ack<cr>
" nnoremap <Leader>aw :Ack <cword><cr>

"---------------Anzu word search count plugin---------------------

" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)


" statusline
set statusline=%{anzu#search_status()}


" if start anzu-mode key mapping
" anzu-mode is anzu(12/51) in screen
nmap n <Plug>(anzu-mode-n)
nmap N <Plug>(anzu-mode-N)

"---------------syntastic plugin---------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
"
"
" "Extra
" let g:syntastic_ruby_mri_args = "--my --args --here"
" let g:syntastic_ruby_checkers = ['mri']

"---------------ctrlp plugin---------------------
set runtimepath^=~/.vim/bundle/ctrlp.vim

"let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_by_filename = 0

"CtrlP mapping
nnoremap <leader>. :CtrlPTag<cr>


"uncomment to disable plugin
"let g:loaded_ctrlp = 1

"FUNKY ctrlp
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1

"---------------NerdTree plugin---------------------

filetype plugin indent on    " required

"nerdtree toggle
map <C-n> :NERDTreeToggle<CR>

" start NERDTree on start-up and focus active window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let NERDTreeMouseMode=3

" open nerd tree current directory
map <leader>r :NERDTreeFind<cr>

" type ,ev to edit the Vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
