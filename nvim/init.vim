call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'mhinz/vim-startify'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'tpope/vim-commentary' 
Plug 'itchyny/lightline.vim'
Plug 'unblevable/quick-scope'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'sebdah/vim-delve'
Plug 'majutsushi/tagbar'

call plug#end()



source $HOME/.config/nvim/basic.vim
source $HOME/.config/nvim/nerdtree.vim
source $HOME/.config/nvim/lightline.vim
source $HOME/.config/nvim/vim-go.vim
source $HOME/.config/nvim/telescope.vim
source $HOME/.config/nvim/barbar.vim
source $HOME/.config/nvim/coc.vim
source $HOME/.config/nvim/fzf.vim
