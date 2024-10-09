-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/playground'

    use 'mbbill/undotree'

    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim'
        }
    }


    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }
    }
    -- Autocomplete help inside function
    use {
        "ray-x/lsp_signature.nvim",
    }
    -- Autocomplete paths
    use { "hrsh7th/cmp-path" }

    -- Spell checking
    use { "f3fora/cmp-spell" }

    -- git inline status
    use { "lewis6991/gitsigns.nvim" }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Using Packer
    -- use 'navarasu/onedark.nvim'
    use "lunarvim/darkplus.nvim"

    -- LSP Formatting package
    -- use "jose-elias-alvarez/null-ls.nvim"
    -- LSP Formatting package inplace of null-ls
    use 'mhartington/formatter.nvim'

    -- Ensure
    use "WhoIsSethDaniel/mason-tool-installer.nvim"

    -- open to previous line
    use 'ethanholz/nvim-lastplace'

    -- comment things out
    use "tpope/vim-commentary"

    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup()
        end
    }

    -- justfile completions
    use { "NoahTheDuke/vim-just" }
    -- file nav
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    -- code diagnostics
    -- return {
    use { "folke/trouble.nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
    }
    -- -- add TODO, HACK, BUG to trouble
    use { "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }
    -- you know why
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- center text on screen
    use { "folke/zen-mode.nvim" }
    use { "shortcuts/no-neck-pain.nvim", tag = "*" }

    -- test out git vim integration
    use { "tpope/vim-fugitive" }
end)
