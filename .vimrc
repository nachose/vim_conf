set nocompatible
execute pathogen#infect()

"filetype plugin on       " enable plugins
runtime ftplugin/man.vim
runtime macros/matchit.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set incsearch            "incremental search
set ignorecase           "ignore case in searchs
set smartcase            "Ignore command ignorecase if the is some uppercase letter"
set scrolloff   =1       "at least 1 line of margin in top and bottom
set history     =50
set autoread             "autorefresh files when updated by another program
set ruler                "add ruler with line, column at the bottom-right
set tabstop     =4
set shiftwidth  =4
set expandtab            "tabs are filled with spaces
set langmenu    =es_es.utf8
set encoding    =utf-8   "file encoding
set cindent              "indentation c style
set showmatch            "show matching parenthesis.
set showcmd              "show partial commands"
set showmode             "show current mode.
set nobackup             "do not backup files.

"Read .cpp when opening .h and also the contrary
"au BufRead,BufNewFile *.h exe "bel vsplit" fnameescape(expand("<amatch>:r").".cpp")
"au BufRead,BufNewFile *.cpp exe "vsplit" fnameescape(expand("<amatch>:r").".h")

set backspace=indent,start,eol   "indent ->allows to delete indents
"eol    ->allows to delete line breaks.
"start  ->allows to move before the
"beginning of the editing.

set shortmess+=T "No hace falta pulsar <Enter> cuando hay un error.                                 

"colorscheme torte        "color scheme.
"colorscheme DarkBlue
"set guifont=Consolas:h14:b:cANSI
set guifont=Monospace\ Bold:h14:b:cANSI



set nu                   "line numbers in the left
"pliegues activados.
set foldenable
"activar plegado por tabulación.
"set foldmethod=indent
"activar plegado manual.
set foldmethod=manual
"nivel de plegado a partir de 1 tabulación.
set foldlevel=10


" omnicppcomplete options
" No incluyo boost porque se me va el archivo de tags a 3 GB y se queda sin
" memoria. 
noremap <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude='*.qml' --exclude='*.js' --exclude='*.png' --exclude='*.jpg' --exclude='*.so' -f /home/jose-seco/dev/tags_default_cpp /usr/include/c++/5.4.0/ /home/mirada/workspace/product-inspire<CR><CR>
set tags+=/home/jose-seco/dev/tags_default_cpp
"noremap <C-x><C-x><C-U> :!ctags -R --js-kinds=+p --fields=+iaS --extra=+q --exclude='*.qml' --exclude='*.cpp' -f /home/jose-seco/dev/tags_default_js /home/mirada/workspace/product-inspire<CR><CR>
"set tags+=/home/jose-seco/dev/tags_default_js


"Autocomplete options.
set completeopt=menu,menuone,preview

" --- OmniCppComplete ---
" -- configs --
let OmniCpp_MayCompleteDot      = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow    = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope    = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem     = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch     = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_LocalSearchDecl     = 1 " don't require special style of function opening braces

" -- ctags --
" noremap <ctrl-x>+<ctrl-t> to generate ctags for current folder:
noremap <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags

" Setup the tab key to do autocompletion
function! CompleteTab()   
  let prec = strpart( getline('.'), 0, col('.')-1 )
  if prec =~ '^\s*$' || prec =~ '\s$'
    return "\<tab>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction

inoremap <c-tab> <c-r>=CompleteTab()<cr>

nnoremap <silent> <F6> :TlistToggle<CR>

nnoremap <silent> <F7> :NERDTreeToggle C:\workcopy<CR>

"Mapas de distintas teclas

noremap <F8> : mksession! /home/jose-seco/dev/nacho_vim_session<CR> 
noremap <F9> : source     /home/jose-seco/dev/nacho_vim_session<CR>

"set backupdir =C:\temp
set noswapfile   "no generar archivos de swap. Si se va la luz me quedo sin los cambios, pero es menos molesto.
set autowrite    "salva el archivo actual al cambiar de buffer.

set sessionoptions+=curdir
set sessionoptions+=folds
set sessionoptions+=help
set sessionoptions+=tabpages
set sessionoptions-=options
set sessionoptions-=localoptions

autocmd BufRead *.qs set syntax=javascript         "Si se lee un qs la sintaxis es javascript. 
autocmd BufRead *.vim set syntax=vim
autocmd BufRead *.sh set syntax=sh


"****************** Configuring a.vim **********************"

" Mappings for C and C++
"***********************************************************"

autocmd FileChangedShell *
      \ echohl WarningMsg |
      \ echo "File has been changed outside of vim." |
      \ echohl None

nnoremap <C-Tab> gt<CR>
nnoremap <S-C-Tab> gT<CR>
noremap <C-right> <ESC>gt<CR>
noremap <C-left>  <ESC>gT<CR>
nnoremap <C-n> :tabe<CR>

" """"""""""""""""""""""""""""""""""""
" Barra de status.
" """"""""""""""""""""""""""""""""""""
"Poner el formato a la status line.
set statusline=%F%m%r%h%w\ [format=%{&ff}]\ [type=%Y]\ [ascii=\%03.3b]\ [hex=\%02B]\ [pos=%04l,%04v]\ [%p%%]\ [len=%L]
"Hacer la barra de status visible.
set laststatus=2
"Hacer la barra de status invisible.
"set laststatus=0
""""""""""""""""""""""""""""""""""""""

" """"""""""""""""""""""""""""""""
" Marcadores de linea y columna.
" """"""""""""""""""""""""""""""""
set cursorline
"quitar el cursor line.
"set nocursorline
"Poner el marcador de columna.
"set cursorcolumn
"Quitar el marcador de columna.
"set nocursorcolumn
"""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
"Mapeos propios (de Nacho)
""""""""""""""""""""""""""""""""""""""
"Mapear en modo inserción el Ctrl + S a salvar.
inoremap <C-s> <ESC>:w<CR>
inoremap <C-S> <ESC>:w<CR>
"Mapear la combinación luf para hacer un LookupFile.
nnoremap luf :LookupFile<CR>
"Mapear te para hacer un :tabedit % 
nnoremap te :tabedit %<CR>

"""""""""""""""""""""""""""""""""""""""

"Ver también los caracteres no visibles.
"set list
"Que no se vean los caracteres no visibles.
set nolist


" Experimental, pongo esta variable global a 1 para que solamente tome paths
" locales.
let g:alternateRelativeFiles = 1

let mapleader = "_"

nnoremap <leader>ic  :call IntroduceConstant()<CR>
nnoremap <leader>rp  :call ReorderParameters()<CR>
nnoremap <leader>rvp :call RemoveParameter()<CR>
nnoremap <leader>rv  :call RenameVariable()<CR>
nnoremap <leader>lvp :call LocalVariableToParameter()<CR>
vnoremap <leader>em  :call ExtractMethod()<CR>

"Select inner word.
nnoremap <space> viw
"Lower line one line.
nnoremap + ddp
"Rise line one line.
nnoremap - ddkP
"Delete line in insert mode.
inoremap <c-d> <esc>ddi
"Uppercase inner word
inoremap <c-u> <esc>viwUi
"Uppercase inner word.
nnoremap <c-u> viwU<esc>
"Seleccionar el interior de parentesis
nnoremap <c-z> vi{
"Seleccionar e indentar.
nnoremap <c-k><c-f> vi{=
"Seleccionar e indentar el archivo entero.
nnoremap <c-i> ggVG=
"Mapear _ev a abrir _vimrc.
nnoremap <leader>ev :tabe $MYVIMRC<CR>
"Reload _vimrc.
nnoremap <leader>sv :source $MYVIMRC<CR>
"Surround word with "
:nnoremap <leader>" viw<esc>i"<esc>hbi"<esc>lel
"Surround word with '
:nnoremap <leader>' viw<esc>i'<esc>hbi'<esc>lel
"Surround with ()
:nnoremap <leader>( viw<esc>i)<esc>hbi(<esc>lel
"Surround selected text with ".
:vnoremap <leader>a" `<vi"<esc>`>i"<esc>
"Escape of insert mode with kj
:inoremap kj <esc>
"Ctrl +W para cerrar pestañas.
:nnoremap <c-x> :clo<cr>
"Ctrl + E para una nueva pestaña.
:nnoremap <c-e> :tabe<cr>
"Ctrl+Inicio para ir al primer tab.
:nnoremap <c-Home> :tabr<cr>
"Ctrl+Fin para ir al ultimo tab.
:nnoremap <c-End> :tabl<cr>
"_so para ordenar una lista.
:vnoremap <leader>so :sort<cr>
"set syntax=cpp
:nnoremap <leader>cpp :set syntax=cpp<cr>
"set syntax=js
:nnoremap <leader>js :set syntax=js<cr>
"move tab + 1
:nnoremap <c-+> :tabm +1<cr>
"move tab - 1
:nnoremap <c--> :tabm -1<cr>
"no higlight mapped to _nh
:nnoremap _nh :noh<cr>
"close all tabs.
:nnoremap <leader>ca :tabdo tabc<cr>
"remove writing restrictios for this file.
:nnoremap <leader>rwr :!chmod a+w %<cr>:edit<cr>

"Syntastic
"Disable includes.
let g:syntastic_cpp_no_include_search = 1
"Disable default includes.
"Check on open and on save.
let g:syntastic_check_on_open=1
"Error in command line.
let g:syntastic_echo_current_error=1
"
"int count = FILLING_RULE::RecordCount( );
let g:syntastic_cpp_no_default_include_dirs = 1
"Delete include errors.
let g:syntastic_cpp_remove_include_errors = 1
"Set syntastic checkers.
"let g:syntastic_cpp_checkers = ['cppcheck', 'cpplint', 'clang-tidy', 'clang-check', 'gcc']
let g:syntastic_cpp_checkers = ['cppcheck', 'cpplint', 'clang-tidy', 'clang-check','gcc' ]

"Args for cpplint here.
let g:syntastic_cpp_cpplint_args = "--filter=-whitespace,-build/include_order,-build/include"

let g:syntastic_cpp_gcc_args = "-Wmissing-include-dirs -std=c++14"

"Show errors for all checkers.
let g:syntastic_aggregate_errors = 1

let g:syntastic_python_pylint_args = "--rcfile=~/.vim/pylint.rc"
"enable pylint for python"
let g:syntastic_python_checkers = ['pylint']


let g:Tlist_Ctags_Cmd = 'c:\workcopy\utils\ctags.exe'
let g:Tlist_WinWidth = 50

"Autocomplete menu colors.
:highlight Pmenu guibg=CornflowerBlue
:highlight Pmenu guifg=Black
:highlight PmenuSel guibg=Black
:highlight PmenuSel guifg=CornflowerBlue

"Create doxygen header of function.
:nnoremap <leader>d :Dox<CR>
let g:DoxygenToolkit_paramTag_post = " [in] "

"Directory of execution is that of Forandesa.
"cd c:\workcopy\ForanDesa\src\

"Try to get the correct directory.
autocmd BufReadPost *.cpp cd %:p:h/
autocmd BufReadPost *.h   cd %:p:h/
autocmd BufReadPost *.hh  cd %:p:h/
autocmd BufReadPost *.c   cd %:p:h/
autocmd BufReadPost *.qs  cd %:p:h/
autocmd BufReadPost *.fcs cd %:p:h/
autocmd TabEnter    *.*   cd %:p:h/

"Save automatically all files when focus lost.
":au FocusLost * silent! wa

"Commands for differences svn.
:nnoremap <leader>diff :VCSDiff<cr>
:nnoremap <leader>bla :VCSAnnotate<cr>

"Set ant as make program.
":set makeprg=ant<cr>


"Rainbow parenthesis plugin.
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"CtrlP Configuration

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"Set list of characters to be seen when using command :set list. Whatever is not this is then a simple whitespace
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

"You complete me pluging
