" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=.docx,.jpg,.png,.gif,.pdf,.pyc,.exe,.flv,.img,.xlsx
set clipboard^=unnamed,unnamedplus
" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with. 
" Press enter and then confirm each change you agree with y or decline with n.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-c> "*y

" Color scheme
let g:airline_theme='one'
colorscheme one
set background=dark
let g:one_allow_italics = 1

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'sheerun/vim-polyglot'
  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'rakr/vim-one'

call plug#end()

" }}}
