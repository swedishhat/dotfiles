" Plugin fun
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/goyo.vim' "Distraction-free writing in Vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " a command line fuzzy finder
Plug 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plug 'w0rp/ale' " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-unimpaired' " Pairs of handy bracket mappings
Plug 'qpkorr/vim-bufkill' " Unload, delete or wipe a buffer without closing the window or split
Plug 'scrooloose/nerdtree' " A tree explorer plugin for vim.
Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
Plug 'sheerun/vim-polyglot' " A solid language pack for Vim.
Plug 'tpope/vim-repeat' " enable repeating supported plugin maps with '.'
" Plug 'supercollider/scvim' " A vim plugin for supercollider
Plug 'tpope/vim-sensible' " a universal set of defaults that (hopefully) everyone can agree on
Plug 'vim-syntastic/syntastic' " Syntastic is a syntax checking plugin
Plug 'wannesm/wmgraphviz.vim' " Vim plugin for Graphviz
Plug 'neoclide/coc.nvim', {'branch': 'release'} "stable - a completion framework and language server client which supports extension features of VSCode
" Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'} " nightly

" Themes and styles
Plug 'patstockwell/vim-monokai-tasty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'rust-lang/rust.vim'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'


call plug#end()

filetype on
filetype plugin on
filetype indent on

let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty

" Optional themes for airline/lightline
let g:airline_theme='monokai_tasty'                   " airline theme
let g:lightline = { 'colorscheme': 'monokai_tasty' }  " lightline theme

" `What` will print out the syntax group that the cursor is currently above.
" from https://www.reddit.com/r/vim/comments/6z4aau/how_to_stop_vim_from_autohighlighting_italics_in/
command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')

" 'relativenumber' is not a complete replacement for 'number'; rather, these two options interact so that you can show only relative numbers (number off and relativenumber on), only absolute line numbers (relativenumber off and number on), or show the absolute number on the cursor line and relative numbers everywhere else (both relativenumber and number on). 
set number
set relativenumber

" For tab characters that appear 4-spaces-wide
" set tabstop=4
" set softtabstop=0 noexpandtab
" set shiftwidth=4

" For indents that consist of 4 space characters but are entered with the tab key
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Run the current file by pressing F9
nnoremap <F9> :!%:p<Enter><Enter>

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

autocmd FileType mail set formatoptions+=t textwidth=72 " enable wrapping in mail
autocmd FileType human set formatoptions-=t textwidth=0 " disable wrapping in txt

" for C-like  programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c,cpp,java set formatoptions+=ro
autocmd FileType c set omnifunc=ccomplete#Complete



" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

" Uses Goyo to put Neovim into a cool sort of prose mode for general text
" editing
function! ProseMode()
	call goyo#execute(0, [])
	set spell noci nosi noai nolist noshowmode noshowcmd
	set complete+=s
	set bg=light
	if !has('gui_running')
		let g:solarized_termcolors=256
	endif
	colors solarized
endfunction

command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>


" Allows for file to be created along with parent directories
function! s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
        	endif
	endif
endfunction

augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
