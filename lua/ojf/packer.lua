-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Fuzzy Search
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Theme
	use ({
		"ishan9299/nvim-solarized-lua",
		as = "solarized",
		config = function()
			vim.cmd('colorscheme solarized')
		end
	})

	-- Syntax Highlighting
	use( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	-- Undo
	use( 'mbbill/undotree' )

	-- Git
	use( 'tpope/vim-fugitive' )

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		requires = {
			{
				"williamboman/mason.nvim",
				{ run = ":MasonUpdate" }
			},
			{ "williamboman/mason-lspconfig.nvim" },
		}
	}

	-- Autocompletion
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			-- Snipets
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp'
		}
	}

	-- Useful plugin to show you pending keybinds.
	use { 'folke/which-key.nvim' }

	-- For neovim configging
	use { 'folke/neodev.nvim' }
end)
