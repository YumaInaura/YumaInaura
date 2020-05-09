:syntax on
:set number
:set paste

set clipboard+=unnamed
set backspace=indent,eol,start

"Insert newline 
"nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

map <F5> :!%:p<Cr>

:set expandtab
:set tabstop=2

set encoding=utf-8
set fileencodings=utf-8