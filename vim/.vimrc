call plug#begin('~/.vim/plug')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'raimondi/delimitmate' " Complete braces and quotes
Plug 'kristijanhusak/vim-hybrid-material' " Color scheme
call plug#end()

" Colorscheme setup
set background=dark
colorscheme hybrid_material

set nocompatible
syntax on

filetype plugin on

set number relativenumber
let mapleader="\<Space>" 

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

" Markdown and Latex linewidth setting
au BufReadPost,BufNewFile *.md,*.txt,*.tex setlocal tw=70

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
nmap yssb yss}
nmap ysiwb ysiw}
noremap <leader>f :NERDTreeToggle<CR>
noremap <leader><leader> /<++><CR>ca<
nmap <leader>d i<++><Esc>b
nmap <leader>D a<++><Esc>b
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>
noremap <leader>c I# <Esc>0
noremap <leader>s :w<Esc>
" noremap <leader>S :wq<CR>
noremap <leader>q :q<Esc>

" map <C-s> :source $HOME/.vimrc
vnoremap <C-c> "+y<Esc>

nmap <C-m> :Goyo<cr>

" ascii headers!
nmap <leader>;a o<Esc><Esc>57i#<Esc><Esc>o#<Esc>7a	<Esc><Esc>a#<Esc>yy2p3lx<leader>D2kyy3jp4k0
