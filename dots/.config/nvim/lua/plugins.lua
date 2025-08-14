local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'	
	use 'ellisonleao/gruvbox.nvim'
    -- use 'm4xshen/autoclose.nvim'
   	use {
   	    'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use  {
        'nvim-treesitter/nvim-treesitter', 
        run = ':TSUpdate' -- automatically update tree-sitter parsers
    }
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    use 'mbbill/undotree'

    -- Lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use 'lervag/vimtex'
    use  {'NeogitOrg/Neogit',
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        }
    }
    use 'sindrets/diffview.nvim' 
    use 'jose-elias-alvarez/null-ls.nvim'
    use({
       'MeanderingProgrammer/render-markdown.nvim',
       after = { 'nvim-treesitter' },
       requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
       -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
       -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
       config = function()
          require('render-markdown').setup({})
       end,
    })   use 'norcalli/nvim-colorizer.lua'
end)
