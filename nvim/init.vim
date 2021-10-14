call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

Plug 'romgrk/barbar.nvim'
Plug 'hoob3rt/lualine.nvim'

Plug 'unblevable/quick-scope'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'sebdah/vim-delve'
Plug 'majutsushi/tagbar'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'simnalamburt/vim-mundo'

Plug 'vimwiki/vimwiki'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-fugitive'

"Lsp setup
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe' 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'glepnir/lspsaga.nvim' 
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-treesitter/playground'
Plug 'folke/trouble.nvim'

call plug#end()


source $HOME/.config/nvim/basic.vim
source $HOME/.config/nvim/nerdtree.vim
source $HOME/.config/nvim/vim-go.vim
source $HOME/.config/nvim/telescope.vim
source $HOME/.config/nvim/barbar.vim
source $HOME/.config/nvim/fzf.vim
source $HOME/.config/nvim/ultisnips.vim
source $HOME/.config/nvim/mundo.vim
source $HOME/.config/nvim/vim-wiki.vim


" Trouble 
lua << EOF
  require("trouble").setup {
  }
EOF

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>


" Lualine
lua << EOF 
    require'lualine'.setup {
      options = {
	icons_enabled = true,
	theme = 'gruvbox',
	component_separators = {'', ''},
	section_separators = {'', ''},
	disabled_filetypes = {}
      },
      sections = {
	lualine_a = {'mode'},
	lualine_b = {'branch'},
	lualine_c = {'filename'},
	lualine_x = {'encoding', 'fileformat', 'filetype'},
	lualine_y = {'progress'},
	lualine_z = {'location'}
      },
      inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {'filename'},
	lualine_x = {'location'},
	lualine_y = {},
	lualine_z = {}
      },
      tabline = {},
      extensions = {}
    }
EOF 


" lspsaga
lua <<  EOF
    local saga = require 'lspsaga'
    saga.init_lsp_saga()
EOF

nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent><leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> DD <cmd>lua require'lspsaga.provider'.preview_definition()<CR>


" lsp config golang
lua << EOF
 require'lspconfig'.gopls.setup{}
EOF

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" auto-format
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)

" compe
lua << EOF
    vim.o.completeopt = "menuone,noselect"

    require'compe'.setup {
      enabled = true;
      autocomplete = true;
      debug = false;
      min_length = 1;
      preselect = 'enable';
      throttle_time = 80;
      source_timeout = 200;
      incomplete_delay = 400;
      max_abbr_width = 100;
      max_kind_width = 100;
      max_menu_width = 100;
      documentation = false;

      source = {
	path = true;
	buffer = true;
	calc = true;
	vsnip = true;
	nvim_lsp = true;
	nvim_lua = true;
	spell = true;
	tags = true;
	snippets_nvim = true;
	treesitter = true;
      };
    }
    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
	    return true
	else
	    return false
	end
    end

    -- Use (s-)tab to:
    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder
    _G.tab_complete = function()
      if vim.fn.pumvisible() == 1 then
	return t "<C-n>"
      elseif vim.fn.call("vsnip#available", {1}) == 1 then
	return t "<Plug>(vsnip-expand-or-jump)"
      elseif check_back_space() then
	return t "<Tab>"
      else
	return vim.fn['compe#complete']()
      end
    end
    _G.s_tab_complete = function()
      if vim.fn.pumvisible() == 1 then
	return t "<C-p>"
      elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
	return t "<Plug>(vsnip-jump-prev)"
      else
	-- If <S-Tab> is not working in your terminal, change it to <C-h>
	return t "<S-Tab>"
      end
    end

    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF


" treesitter 
"
lua <<EOF
    require'nvim-treesitter.configs'.setup {
      highlight = {
	enable = true,              -- false will disable the whole extension
	additional_vim_regex_highlighting = false,
      },
    }
EOF

" ---------------------------------------------
" Lsp Install 
lua << EOF
    local function setup_servers()
      require'lspinstall'.setup()
      local servers = require'lspinstall'.installed_servers()
      for _, server in pairs(servers) do
	require'lspconfig'[server].setup{}
      end
    end

    setup_servers()

    require'lspinstall'.post_install_hook = function ()
      setup_servers() -- reload installed servers
      vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end
EOF

lua << EOF 
    require "nvim-treesitter.configs".setup {
      playground = {
	enable = true,
	disable = {},
	updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
	persist_queries = false, -- Whether the query persists across vim sessions
	keybindings = {
	  toggle_query_editor = 'o',
	  toggle_hl_groups = 'i',
	  toggle_injected_languages = 't',
	  toggle_anonymous_nodes = 'a',
	  toggle_language_display = 'I',
	  focus_language = 'f',
	  unfocus_language = 'F',
	  update = 'R',
	  goto_node = '<cr>',
	  show_help = '?',
	},
      }
    }

EOF 
