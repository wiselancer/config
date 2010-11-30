" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on


set autoindent
set smartindent

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd   " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set ignorecase    " Do case insensitive matching
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set expandtab            " convert tabs to spaces
set softtabstop=2           " tab of length 2
set shiftwidth=2        " indentation tab to 2 spaces
set nowrap      " do not wrap lines
set scrolloff=4 " Always show 4 lines above and bellow cursor (context)

au BufNewFile,BufRead *.module set filetype=php
au BufNewFile,BufRead *.test set filetype=php
au BufNewFile,BufRead *.install set filetype=php
au BufNewFile,BufRead *.inc set filetype=php


" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" autocmd FileType inc set omnifunc=phpcomplete#CompletePHP


" set tags=./tags;/var/www

" custom keybinginds (left key press perform the right key commands)

" Toggle fold
noremap f za
" Close all folds
noremap F zM
" Open all folds
noremap ,f zR

 set guifont=Monaco "Sam custom - add custom font

 highlight Cursor guibg=Black guifg=NONE
 let g:user_zen_expandabbr_key = '<c-e>' "Sam custom - add keybin to zen_codding
 let g:user_zen_next_key = '<c-space>' "Sam custom - add keybin to zen_codding

 set number "Sam custom - add number

 set tabstop=2
 set encoding=utf-8
 set termencoding=utf-8
 colorscheme desert
 set backspace=indent,eol,start
 syntax enable
 filetype on

"Sam custom - add php-doc plugin
source ~/.vim/plugin/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

source ~/.vim/after/plugin/snipMate.vim
