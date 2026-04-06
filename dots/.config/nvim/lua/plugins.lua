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

    -- AI sloppy
    use 'github/copilot.vim'

    -- Plugin manager
    use 'wbthomason/packer.nvim'
    
    -- Colorschemes
    use 'ellisonleao/gruvbox.nvim'
    use 'shaunsingh/nord.nvim'
    use 'e-ink-colorscheme/e-ink.nvim'
    
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    
    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        run = ':TSUpdate'
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
    }
    
    -- Navigation
    use {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    --[[
    use {
        'scalameta/nvim-metals',
        ft = { 'scala', 'sbt', 'java' },
        opts = function()
            local metals_config = require('metals').bare_config()
            metals_config.on_attach = function(client, bufnr)
                -- your on_attach function
            end
            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                pattern = self.ft,
                callback = function()
                    require('metals').initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    }
    ]]
    
    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    
    -- Git
    use {
        'NeogitOrg/Neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        }
    }
    use 'sindrets/diffview.nvim'
    
    -- Utilities
    use 'lervag/vimtex'
    use 'stevearc/conform.nvim'
    use 'NvChad/nvim-colorizer.lua'
    use 'Aasim-A/scrollEOF.nvim'
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }
end)
