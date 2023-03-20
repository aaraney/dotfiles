call plug#begin('~/.vim/plug')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
" Plug 'kristijanhusak/vim-hybrid-material' " Color scheme
Plug 'raimondi/delimitmate' " Complete braces and quotes
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'wojciechkepka/vim-github-dark'

" lsp plugins
Plug 'neovim/nvim-lspconfig'

" completion plugins
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" lua snips
Plug 'L3MON4D3/LuaSnip'
call plug#end()

" enable airline tabline
let g:airline#extensions#tabline#enabled = 1


" change airline default theme
let g:airline_theme='minimalist'

" completion options
set completeopt=menu,menuone,noselect

" Colorscheme setup
" set background=dark
" colorscheme hybrid_material
let g:gh_color="soft"
colorscheme ghdark

" Set textwidth to 100
set textwidth=100
" set colorcolumn=100

" use 4 spaces instead of a tab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set nocompatible
syntax on

filetype plugin on

set number relativenumber
let mapleader="\<Space>" 

" persistent undo
set undofile
set undodir=~/.vim/undodir

" lsp imports
lua require("key_remaps")
" completions
lua require("nvim_cmp")

" open fzf.vim files based on current context
" if in git repo, use :GitFiles else :Files
function SmartFiles()
	let git_status = system("git status")
	if v:shell_error != 0
		" current directory context
		Files
	else
		" full git repo context
		GitFiles
	endif
endfunction

" open fzf with leader - p
noremap <leader>p :call SmartFiles() <cr>

" toggle between buffers
nnoremap <leader>t :bn<cr>
nnoremap <leader>T :bp<cr>

" close current buffer
command! CloseBufferOrExit :echo len(getbufinfo({'buflisted':1})) > 1 ? execute('bd') : execute('q')
nnoremap <leader>w :CloseBufferOrExit <cr>


" Enables the use of tab complete in normal mode
set wildmode=longest,list,full
set wildmenu " In normal mode : + tab will open small window with options

" Search options
set ignorecase smartcase 
set nowrapscan " Search will not loop back to top if hits the bottom

set splitbelow splitright " Defaults to split screen to the bottom or right

" Remap splits to get rid of holding ctrl
noremap <C-H> <C-W><C-H>
noremap <C-L> <C-W><C-L>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>

" python fixing
" let g:ale_python_black_executable = '/usr/local/Caskroom/miniconda/base/envs/vscode_utils/bin/black'
" let g:ale_fixers = {'python': ['black']}
" let g:ale_fix_on_save = 1
" let g:ale_linters = {
" \ 'go' : ['gopls'],
" \}

" ale config
" let g:ale_completion_enabled = 1
" let g:ale_completion_autoimport = 1

" Markdown and Latex linewidth setting
" au BufReadPost,BufNewFile *.md,*.txt,*.tex setlocal tw=70

" Neomutt textwidth settings
au FileType mail setlocal tw=0
au FileType mail :Goyo 65

" Open to the last line left
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Filetype key remapping
" compiler key mapping
autocmd FileType tex noremap <leader>b :w! \| !compiler  %<CR><CR>
autocmd FileType python noremap <leader>b :w! \| !compiler  %<CR>
autocmd FileType markdown noremap <leader>b :w! \| !compiler  %<CR><CR>

" Filetype key remapping for LaTeX
autocmd FileType tex noremap ;r i\ref{<++>}<Esc>?ref<CR> 0
autocmd FileType tex noremap ;l i\label{<++>}<Esc>?label<CR> 0
autocmd FileType tex noremap ;eq i\begin{equation}<CR><++><CR>\end{equation}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;en i\begin{enumerate}<CR><++><CR>\end{enumerate}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;i i\begin{itemize}<CR><++><CR>\end{itemize}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;m i\begin{minipage}{.5\textwidth}<CR><++><CR>\end{minipage}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;b i\begin{<++>}<CR><++><CR>\end{<++>}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;s i\section{<++>}<Esc>B
autocmd FileType tex noremap ;ss i\subsection{<++>}<Esc>B
autocmd FileType tex noremap ;it i\item<Space>
autocmd FileType tex noremap ;ig i\includegraphics[width=.<++>\textwidth]{<++>}<Esc>B
autocmd FileType tex noremap ;f i\begin{figure}[H]<CR><++><CR>\caption{<++>}<CR>\end{figure}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;wf i\begin{wrapfigure}{r}{<++>\textwidth}<CR><++><CR> \caption{<++>}<CR>\end{wrapfigure}<Esc>?begin<CR> 0
autocmd FileType tex noremap ;pb i\printbibliography<CR><Esc>?print<CR> 0
" Filetype key remapping specfic for Beamer
autocmd FileType tex noremap ;fr i\begin{frame}{<++>}<CR><++><CR>\end{frame}<Esc>?begin<CR> 0

" Filetype key remapping for Markdown
autocmd FileType markdown noremap ;b ciw**<Esc>pa**<Esc>
autocmd FileType markdown noremap ;i ciw_<Esc>pa_<Esc>
autocmd FileType markdown nmap ;d I###### <esc><leader>D o* <esc><leader>D <Esc>?######<CR><leader><leader>
autocmd FileType markdown nmap ;h I###<space>
autocmd FileType markdown nmap ;H I##<space>
autocmd FileType markdown nmap ;l I*<space>
autocmd FileType markdown noremap ;ig i\includegraphics[width=.<++>\textwidth]{<++>}<Esc>B
autocmd FileType markdown noremap ;f i\begin{figure}<CR><++><CR>\end{figure}<Esc>?begin<CR> 0

" Filetype editor behavior for Markdown
autocmd FileType markdown setlocal expandtab tabstop=2 shiftwidth=2 expandtab

" Filetype editor behavior for Yaml
autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 expandtab

" Filetype key remapping for vi mode terminal
" Quit and don't execute command
autocmd FileType sh noremap ;qq :cq<CR> 
autocmd FileType sh noremap ;f ifor <++> in <++><Esc>odo<Esc>o<++><Esc>odone<Esc>?for<CR>
autocmd FileType sh noremap ;v i"${<++>}"<Esc>?\$<CR>
autocmd FileType sh noremap ;if i if [ <++> ];<Esc>othen<Esc>o<++><Esc>ofi<Esc>?if<CR>

" Filetype key remapping for vimrc 
autocmd FileType vim noremap <M-r> :source ~/.vimrc<CR>

" Spelling remaps
noremap <leader>n ]s
noremap <leader>N [s
noremap <leader>z z=
noremap <leader>S :set spell! spelllang=en_us <CR> 

" General key remapping
noremap <leader><S-b> :!open -a /Applications/Skim.app %:r.pdf<CR><CR>

" vim surround word with something
nmap <leader><C-s> ysiw
nmap yssb yss}
nmap ysiwb ysiw}

noremap <leader>f :NERDTreeToggle<CR>

" noremap <leader><leader> /<++><CR>ca<
" nmap <leader>d i<++><Esc>b
" nmap <leader>D a<++><Esc>b

map <leader>c gcc

" saving and quiting remaps
noremap <leader>s :w<Esc>
noremap <leader>q :q<Esc>

" map <C-s> :source $HOME/.vimrc
vnoremap <C-c> "+y<Esc>

" command+shift-c to toggle goyo
nmap <leader>m :Goyo <cr>
let g:goyo_width = 120

" ascii headers!
nmap <leader>;a o<Esc><Esc>57i#<Esc><Esc>o#<Esc>7a	<Esc><Esc>a#<Esc>yy2p3lx<leader>D2kyy3jp4k0
