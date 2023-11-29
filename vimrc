" share with OS clipboard
set clipboard=unnamed,unnamedplus

" vim setting
set timeout timeoutlen=1000 ttimeoutlen=50
set wildmenu

" Line
set number
set cursorline
set cursorcolumn
set scrolloff=4

" Cursur
set showmatch
if has('vim_starting')
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif

" Tab
set expandtab
set tabstop=2
set backspace=2
set autoindent
set smartindent

" Search
set hlsearch

" mouse
set mouse=a
set ttymouse=xterm2

" Autocorrect
autocmd BufWritePre * :%s/\s\+$//ge

" move
set whichwrap=b,s,h,l,<,>,[,],~
map <S-h> ^
map <S-l> $
map <S-j> 5j
map <S-k> 5k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k

vmap u <Nop>
noremap ; :
noremap <leader>x :noh<CR>

" ***** Plugins
call plug#begin()
  Plug 'knsh14/vim-github-link'
  Plug 'zivyangll/git-blame.vim'
  Plug 'github/copilot.vim'
  Plug 'kien/ctrlp.vim'
  Plug 'mattn/ctrlp-matchfuzzy'
  Plug 'fatih/molokai'
  Plug 'itchyny/lightline.vim'
  Plug 'tyru/caw.vim'
  Plug 'preservim/nerdtree'
  Plug 'Shougo/vinarise'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'mattn/vim-goimports'
call plug#end()


" Colorscheme
syntax on

let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

" lightline
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'molokai'
  \ }

" caw
"行の最初の文字の前にコメント文字をトグル
map <Leader>c <Plug>(caw:hatpos:toggle)
" 行頭にコメントをトグル
map <Leader>, <Plug>(caw:zeropos:toggle)

" CtrlP
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}

" LSP
nmap <silent> gd :LspDefinition<CR>

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | NERDTreeToggle<CR> | endif

autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let NERDTreeIgnore = ['\.class$','\.swp$','\.pdf','^.git$']


" Vinariser
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | Vinarise
	autocmd BufWritePre * if &binary | Vinarise | endif
	autocmd BufWritePost * if &binary | Vinarise
augroup END

" Git
vmap gt :GetCurrentBranchLink<CR>
nnoremap <Leader>g :<C-u>call gitblame#echo()<CR>
