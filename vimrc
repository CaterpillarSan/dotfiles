" Configuration file for vim

set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
set tabstop=4		" tab = 4 space"
set shiftwidth=4
set clipboard+=unnamed
set number
set cursorline
set cursorcolumn
set hlsearch
set showtabline=2
" " Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" " Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup
syntax on

" キーバインドの設定
" 左端,右端に移動
noremap <C-h>	^
noremap <C-l>	$
noremap <C-k> <C-u>
noremap <C-j> <C-d>
" ペイン移動
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

nnoremap <S-l> gt
nnoremap <S-h> gT

" 勝手に小文字にならないで欲しい
vmap u <esc> 

" escapeをC+jに
"noremap <C-j>	<esc>
imap	<C-j>	<esc>
" USkey対策 ; -> :
noremap ; :
" ハイライト解除
noremap <leader>x :noh<CR>

" マウス操作設定
set mouse=a					   "マウス使用可能
set ttymouse=xterm2			   "スクロール可能
set backspace=indent,eol,start "Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set scrolloff=8				   "上下8行の視界を確保
set sidescrolloff=16		   " 左右スクロール時の視界を確保
set sidescroll=1			   " 左右スクロールは一文字づつ行う
set laststatus=2

" *********************************************:
"  タブ設定
" *********************************************:

" " 各タブページのカレントバッファ名+αを表示
" function! s:tabpage_label(n)
"   " t:title と言う変数があったらそれを使う
"   let title = gettabvar(a:n, 'title')
"   if title !=# ''
"     return title
"   endif
"
"   " タブページ内のバッファのリスト
"   let bufnrs = tabpagebuflist(a:n)
"
"   " カレントタブページかどうかでハイライトを切り替える
"   let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
"
"   " バッファが複数あったらバッファ数を表示
"   let no = len(bufnrs)
"   if no is 1
"     let no = ''
"   endif
"   " タブページ内に変更ありのバッファがあったら '+' を付ける
"   let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
"   let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける
"
"   " カレントバッファ
"   let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
"   let fname = pathshorten(bufname(curbufnr))
"
"   let label = no . mod . sp . fname
"
"   return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
" endfunction
"
" function! MakeTabLine()
"   let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
"   let sep = ' | '  " タブ間の区切り
"   let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
"   let info = ''  " 好きな情報を入れる
"   return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
" endfunction
"
" set tabline=%!MakeTabLine()

" *********************************************:
" ***************  Plugins  *******************:
" *********************************************:
" Neobundle
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif 

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" 以下プラグイン
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'fatih/molokai'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'fatih/vim-go',  { 'do': ':GoInstallBinaries' }
NeoBundle 'prettier/vim-prettier'
NeoBundle 'AndrewRadev/splitjoin'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'tarekbecker/vim-yaml-formatter'
NeoBundle 'Shougo/vinarise'
call neobundle#end()


filetype plugin indent on

" *********************************************:
" * Colorscheme
" *********************************************:
let g:rehash256 = 1
let g:molokai_original = 1
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=236
highlight CursorColumn cterm=NONE ctermfg=NONE ctermbg=236
highlight Cursor ctermfg=green ctermbg=NONE
highlight Comment ctermfg=35
highlight Visual term=reverse cterm=reverse ctermfg=darkcyan ctermbg=black
highlight Number ctermfg=202
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html

colorscheme molokai

" *********************************************:
" * lightline環境
" *********************************************:
let lightline = {
		\ 'colorscheme': 'wombat',
		\ 'mode_map': {'c': 'NORMAL'},
		\ 'active': {
		\	'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'absolutepath', 'modified' ] ]
		\ },
		\ 'component_function': {
		\	'modified': 'LightlineModified',
		\	'readonly': 'LightlineReadonly',
		\	'fugitive': 'LightlineFugitive',
		\	'filename': 'LightlineFilename',
		\	'fileformat': 'LightlineFileformat',
		\	'filetype': 'LightlineFiletype',
		\	'fileencoding': 'LightlineFileencoding',
		\	'mode': 'LightlineMode',
        \   'absolutepath': 'AbsolutePath'
		\ }
		\ }

function! LightlineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
		  \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
		  \  &ft == 'unite' ? unite#get_status_string() :
		  \  &ft == 'vimshell' ? vimshell#get_status_string() :
		  \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
		  \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		  return fugitive#head()
		   else
		  return ''
	endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	 return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
	 return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

 function! AbsolutePath()
    let a = substitute(expand('%:p'), $HOME, '~', '')
    if a == ""
      return '🗒'
    elseif strlen(a) > 40
      return a[strlen(a)-40:]
    else
      return a
    endif
  endfunction

" *********************************************:
" * caw 環境(コメントアウト)
" *********************************************:
" "行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" " 行頭にコメントをトグル
nmap <Leader>, <Plug>(caw:zeropos:toggle)
vmap <Leader>, <Plug>(caw:zeropos:toggle)

" *********************************************:
" * neocomplete環境
" *********************************************:
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" *********************************************:
" * neosnippet環境
" *********************************************:
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/'

" Plugin key-mappings.
imap <C-k>	   <Plug>(neosnippet_expand_or_jump)
smap <C-k>	   <Plug>(neosnippet_expand_or_jump)
xmap <C-k>	   <Plug>(neosnippet_expand_target)
"  
 " SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
inoremap <expr><CR>  pumvisible() ?  : "<CR>"
  " For snippet_complete marker.
 if has('conceal')
	set conceallevel=2 concealcursor=i
 endif


" Enable golang autocompletion
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'

 
" *********************************************:
" indent-guide
" *********************************************:
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd	guibg=red	ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
let g:indent_guides_guide_size = 1 
let g:indent_guides_start_level = 1 

" *********************************************:
" NERDTree & Toggle
" *********************************************:

" 開始時のカーソル位置を,NERDTreeではなくファイル側にする
function s:MoveToFile()
	call feedkeys("\<Space>")
	call feedkeys("\<C-w>")
	call feedkeys("\w")
endfunction

let NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_console_startup=1
" let g:nerdtree_tabs_startup_cd=0
map <S-n> :NERDTreeTabsToggle<CR>
let NERDTreeIgnore = ['\.class$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" *********************************************:
" * Priettier環境
" *********************************************:

let g:prettier#autoformat = 0
" let g:prettier#exec_cmd_path = "/usr/local/var/nodebrew/node/v10.8.0/lib/node_modules/prettier"
autocmd BufWritePre *.js,*.jsx,*.ts,*.vue,*.css,*.scss,*.json PrettierAsync


" *********************************************:
" * vim-go環境
" *********************************************:
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
map <C-g>d :GoDeclsDir<CR>

autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

let g:go_fmt_command = "goimports"
let g:go_highlight_function_calls = 1
let g:go_auto_sameids = 1
let g:go_play_browser_command = "chrome"


" *********************************************:
" * tagbar 環境
" *********************************************:

" https://github.com/budougumi0617/dotfiles/blob/fec842a82c88b86a0dfbfdaab9e1e28fbfc06fa7/home/.vimrc#L508-L538
" Need gotags
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
\ }

" Open Tagbar
nmap <F8> :TagbarToggle<CR>

" *********************************************:
" * Vinariser 環境
" *********************************************:

augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | Vinarise
	autocmd BufWritePre * if &binary | Vinarise | endif
	autocmd BufWritePost * if &binary | Vinarise 
augroup END
