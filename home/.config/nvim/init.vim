" Plugin fun
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'supercollider/scvim'
Plug 'tpope/vim-sensible'
Plug 'vim-syntastic/syntastic'

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
