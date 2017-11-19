if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax enable

call plug#begin()
  Plug 'jimmay5469/vim-spacemacs'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-commentary'
  Plug 'chrisbra/csv.vim'
  Plug 'ivanov/vim-ipython'
  Plug 'jnurmine/Zenburn'
  Plug 'scrooloose/nerdtree'
  Plug 'jceb/vim-orgmode'
  Plug 'hecal3/vim-leader-guide'
call plug#end()

let mapleader = "\<SPACE>"

nnoremap <silent> <LEADER> :<C-U>LeaderGuide '<SPACE>'<CR>
vnoremap <silent> <LEADER> :<C-U>LeaderGuideVisual '<SPACE>'<CR>
