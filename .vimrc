if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax enable

call plug#begin()
  Plug 'tpope/vim-sensible'
  Plug 'chrisbra/csv.vim'
  Plug 'ivanov/vim-ipython'
  Plug 'jnurmine/Zenburn'
  Plug 'scrooloose/nerdtree'
  Plug 'jceb/vim-orgmode'
call plug#end()

