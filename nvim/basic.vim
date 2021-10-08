let g:gruvbox_contrast_dark = 'hard'

colorscheme gruvbox
set background=dark
filetype on
filetype plugin on
filetype indent on
set nu
set cursorline
set ignorecase
set autoindent	 "Auto-indent new lines
set shiftwidth=4  "Number of auto-indent spaces
set smartindent	 "Enable smart-indent
set smarttab	 "Enable smart-tabs
set softtabstop=4	"Number of spaces per Tab
set relativenumber
set termguicolors
set encoding=UTF-8
set clipboard+=unnamedplus

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

let mapleader = " "
