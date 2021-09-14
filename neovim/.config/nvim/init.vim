let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
        Plug 'tpope/vim-surround'
        Plug 'junegunn/goyo.vim'
        Plug 'jreybert/vimagit'
        Plug 'vimwiki/vimwiki'
        Plug 'tpope/vim-commentary'
        Plug 'ap/vim-css-color'
	Plug 'bling/vim-airline'
call plug#end()


set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set title
	set encoding=utf-8
	set number relativenumber
        set noruler noshowmode noshowcmd
	" set laststatus=0
	let g:indentLine_char = '▏'

" Automatic folding based on syntax
	set foldmethod=syntax
	set foldlevel=1
	filetype plugin on
	filetype indent on
	let g:sh_fold_enabled= 5
	let g:vimsyn_folding='afP'

" Automatic folding with indent but allows indents to be made
"	augroup vimrc
"	  au BufReadPre * setlocal foldmethod=indent
"	  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"	augroup END


" Enable autocompletion:
	set wildmode=longest,list,full
	set complete+=kspell

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo <CR>
	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>e :setlocal spell! spelllang=en<CR>
	map <leader>n :setlocal spell! spelllang=nb<CR>

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/doc/notes', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile *.md set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Statusbar options

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]

" Commands to execute when calling goyo

	function! s:goyo_enter()
		if executable('tmux') && strlen($TMUX)
			silent !tmux set status off
			silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
		endif
		set scrolloff=999
		set linebreak
	endfunction

	function! s:goyo_leave()
		if executable('tmux') && strlen($TMUX)
			silent !tmux set status on
			silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
		endif
		set scrolloff=0
		set nolinebreak
	endfunction
