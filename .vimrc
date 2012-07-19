if has('win32') || has('win64')
    " Make windows use ~/.vim instead of ~/vimfiles
    set runtimepath^=~/.vim
endif
set nocompatible
autocmd!
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set ffs=unix ",dos,mac "Default file types
set encoding=utf-8
"set virtualedit=all
filetype plugin indent on				" Let filetype plugins indent for me

""""" Searching and Patterns
set ignorecase							" search is case insensitive
set smartcase							" search case sensitive if caps on
set incsearch							" show best match so far

""""" gundo
nnoremap <F5> :GundoToggle<cr>
let g:gundo_right=1
let g:gundo_width=60
let g:gundo_preview_height =40

""""" lusty
set hidden

""""" Display
"set background=dark						" I use dark background
set lazyredraw							" Don't repaint when scripts are running
set scrolloff=3							" Keep 3 lines below and above the cursor
set ruler								" line numbers and column the cursor is on
set number                              " Set line numbers
set ttyfast
set cmdheight=2
set sidescrolloff=3
set colorcolumn=-1
set guifont=Monaco

""Set backup to a location
set backup
set backupdir=$HOME/vim_backup/
set directory=$HOME/vim_swap/

"""" Settings
set spell                               " Dynamic Spell Checking
set nohlsearch
set nocul
set ww=b,<,>,[,]
set nowrap
set undolevels=1000
set updatecount=100
set complete=.,w,b,u,U,t,i,d
set completeopt=longest,menuone
set linespace=0
set guioptions=
set autoread
set gdefault
":highlight PmenuSel ctermfg=black

let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**"

set shiftround " When at 3 spaces and I hit >>, go to 4 not 5.

command! Q q
command! Qall qall

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*

""""" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
""""" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
""""" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'C:\Program Files\SumatraPDF\SumatraPDF.exe -reuse-instance'
let g:Tex_IgnoredWarnings = 7
""""" Persistent undo stuff
set undodir=$HOME/vim_undo/
set undofile

""""" Messages, Info, Status
set shortmess+=a						" Use [+] [RO] [w] for modified, read-only, modified
set showcmd								" Display what command is waiting for an operator
set laststatus=2						" Always show statusline, even if only 1 window
set report=0							" Notify me whenever any lines have changed
set confirm								" Y-N-C prompt if closing with unsaved changes

set statusline=%F%m%r%h%w\ [MODTIME=%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ [%{strftime(\"%d/%m/%y\ -\ %H:%M\")}]\ [POS=%l,%c]\ [COL=%c]\ [LINE=%l]\ [%p%%]\ [LEN=%L]\ 
set statusline+=%#warningmsg#
set statusline+=%*

""""" Editing
set backspace=2							" Backspace over anything! (Super backspace!)
set matchtime=2							" For .2 seconds
set formatoptions+=tco					" I can format for myself, thank you very much
set tabstop=4							" Tab stop of 4
set shiftwidth=4						" sw 4 spaces (used on auto indent)
set softtabstop=4						" 4 spaces as a tab for bs/del
set matchpairs+=<:>						" specially for html
set showmatch							" Briefly jump to the previous matching parent
set noautoindent
set nosmartindent
set nocindent

""""" Coding
set history=100							" 100 Lines of history
set showfulltag							" Show more information while completing tags

"" set up tags
set tags=tags;/
set tags+=$HOME/.vim/tags/python.ctags

""""" Command Line
set wildmenu							" Autocomplete features in the status bar
set wildmode=longest:full,list
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

let g:commandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>z :call RenameFile()<cr>

"" Set spacing guidelines for file types

au BufRead,BufNewFile *.py  set ai ts=4 sw=4 sts=4 et tw=72 " Doc strs
au BufRead,BufNewFile *.js  set ai sw=2 sts=2 et tw=72 " Doc strs
au BufRead,BufNewFile *.html set ai sw=2 sts=2 et tw=72 " Doc strs
au BufRead,BufNewFile *.json set ai sw=4 sts=4 et tw=72 " Doc strs
au BufRead,BufNewFile *.tex set ai sw=4 sts=4 et tw=80 " Doc strs
au BufNewFile *.html,*.py,*.pyw,*.c,*.h,*.json set fileformat=unix
au! BufRead,BufNewFile *.json setfiletype json
au BufNewFile,BufRead *.txt setlocal wrap
au BufNewFile,BufRead *.txt setlocal lbr

let python_highlight_all=1
syntax on

"" Bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
"" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw,*.tex match BadWhitespace /^\t\+/
"" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.tex match BadWhitespace /\s\+$/

set iskeyword+=.

""""" Movement
"" work more logically with wrapped lines
noremap j gj
noremap k gk

colorscheme xoria256
"" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M

"""" Windows
if exists(":tab")						" Try to move to other windows if changing buf
    set switchbuf=useopen,usetab
else									" Try other windows & tabs if available
    set switchbuf=useopen
endif

""""" Autocommands
if has("autocmd")
    "" Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

        "" Filetypes (au = autocmd)
        au FileType helpfile set nonumber      " no line numbers when viewing help
        au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
        au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

        "" When using mutt, text width=72
        au FileType cpp,c,java,sh,pl,php,py,asp  set autoindent
        au FileType cpp,c,java,sh,pl,php,py,asp  set smartindent
        au FileType cpp,c,java,sh,pl,php,py,asp  set cindent
        au FileType py set foldmethod=indent
        au FileType py set textwidth=79  " PEP-8 friendly
        au FileType tex set textwidth=80
        au FileType py inoremap # X#
        au FileType py set expandtab
        au FileType py set omnifunc=pythoncomplete#Complete
        autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/ftplugin/python.vim
        autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
        autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    endif

    function! GetPythonTextWidth()
        if !exists('g:python_normal_text_width')
            let normal_text_width = 79
        else
            let normal_text_width = g:python_normal_text_width
        endif

        if !exists('g:python_comment_text_width')
            let comment_text_width = 72
        else
            let comment_text_width = g:python_comment_text_width
        endif

        let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
        if cur_syntax == "Comment"
            return comment_text_width
        elseif cur_syntax == "String"
            " Check to see if we're in a docstring
            let lnum = line(".")
            while lnum >= 1 && synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String"
                if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
                    " Assume that any longstring is a docstring
                    return comment_text_width
                endif
                let lnum -= 1
            endwhile
        endif

        return normal_text_width
    endfunction
    augroup pep8
        au!
        autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
    augroup END

function! MergeTabs()
    if tabpagenr() == 1
        return
    endif
    let bufferName = bufname("%")
    if tabpagenr("$") == tabpagenr()
        close!
    else
        close!
        tabprev
    endif
    split
    execute "buffer " . bufferName
endfunction
nmap <C-W>u :call MergeTabs()<cr>
"" NerdTree Ignores these
"" filetypes
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$'] "'\.vim$', 
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\.bak$', '\~$']
let NERDTreeShowBookmarks=1


"" Obvious mode settings
let g:obviousModeInsertHi = 'term=reverse ctermbg=52'
let g:obviousModeCmdWinHi = 'term=reversse ctermbg=22'

set expandtab       " tabs are converted to spaces

let mapleader=','
if version >= 600
    set foldenable
    set foldmethod=indent
    set foldlevel=100
endif
let g:screen_size_restore_pos = 1
let g:screen_size_by_vim_instance = 1

function! s:align()
  let p = '^\s*=\s.*\s=\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
    Tabularize/=/l1
    normal! 0
    call search(repeat('[^=]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

inoremap <C-Space> <C-x><C-o>
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>
map <F1> :previous<cr>
map <F2> :next<cr>
map <Leader>v :vsp ~/.vimrc<cr>
map <Leader>e :e ~/.vimrc<cr>
map <Leader>u :source ~/.vimrc<cr>
map <Leader>ft :%s/	/    /g<cr>
"map  :Lodgeit<cr>
map <Leader>cp :botright cope<cr>
map <Leader>n :cn<cr>
map <Leader>p :cp<cr>
nmap . .`[
"map <Leader>cu :Tabularize /\|<cr>
map <Leader>co ggVG"*y
map <Leader>cc <plug>NERDCommenterComment<cr>
map <Leader>c<space> <plug>NERDCommenterToggle<cr>
map <Leader>cm <plug>NERDCommenterMinimal<cr>
map <Leader>cs <plug>NERDCommenterSexy<cr>
map <Leader>ci <plug>NERDCommenterInvert<cr>
map <Leader>cy <plug>NERDCommenterYank<cr>
map <Leader>cl <plug>NERDCommenterAlignLeft<cr>
map <Leader>cb <plug>NERDCommenterAlignBoth<cr>
map <Leader>cn <plug>NERDCommenterNest<cr>
map <Leader>cu <plug>NERDCommenterUncomment<cr>
map <Leader>c$ <plug>NERDCommenterToEOL<cr>
map <Leader>cA <plug>NERDCommenterAppend<cr>
nmap <Leader>tl :set list!<cr>
nmap <Leader>cd :cd%:p:h<cr>
nmap <Leader>lcd :lcd%:p:h<cr>
nmap <Leader>h <C-W>h<Esc>
nmap <Leader>w <C-W>w<Esc>
nmap <Leader>l <C-W>l<Esc>
nmap <Leader>j <C-W>j<Esc>
nmap <Leader>k <C-W>k<Esc>
nmap q: :q
nmap <Leader>fo :%foldopen!<cr>
nmap <Leader>fc :%foldclose!<cr>
nmap <Leader>nn :NERDTreeToggle<cr>
nmap <Leader>gs :Gstatus<cr>
nmap <Leader>gb :Gblame<cr>
vmap <Leader>b :<c-u>!git blame <c-r>=expand("%:p") <cr> \| sed -n <c-r>=line("'<") <cr>,<c-r>=line("'>") <cr>p <cr>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>gac :Gcommit -a -m ""<LEFT>
map <Leader>fix :cnoremap & &<cr>
map <Leader>gm :Gmove<cr>
map <Leader>gg :Ggrep<cr>
map <Leader>gp :Gsplit<cr>
map <Leader>gl :Glog<cr>
map <Leader>grm :Gremove<cr>
map <Leader>i mmgg=G`m<cr>
map <Leader>rw :%s/\s\+$//<cr>:w<cr>
map <Leader>sc :sp<cr>:grep
map <Leader>sp yss<p>
map <Leader>vg :vsp<cr>:grep
map <Leader>vi :tabe ~/.vimrc<cr>
map <Leader>w <C-w>w

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
"map <Leader>e :e <C-R>=expand("%:p:h") . '/'<cr>
"map <Leader>s :split <C-R>=expand("%p:h") . '/'<cr>
"map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<cr>

map <C-h> :nohl<cr>
imap <C-l> :<Space>
map <C-t> <esc>:tabnew<cr>
map <C-x> <C-w>c
map <C-n> :cn<cr>
map <C-p> :cp<cr>
nmap <F11> 1G=G
imap <F11> <ESC>1G=Ga
nmap <F11> 1G=G
map <F11> <ESC>1G=Ga
