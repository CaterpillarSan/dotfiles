set clipboard=unnamed,unnamedplus
set number
set expandtab tabstop=2 shiftwidth=2
set hlsearch
set mouse=a
set backspace=indent,eol,start

autocmd BufWritePre * :%s/\s\+$//ge

map <S-h> ^
map <S-l> $
noremap ; :
