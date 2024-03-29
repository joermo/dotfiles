local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })

end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "folke/which-key.nvim",
--    { "folke/neoconf.nvim",
--        cmd = "Neoconf"
--    },
--    "folke/neodev.nvim",
    ----------------------
    -- Required plugins --
    ----------------------
    "nvim-lua/plenary.nvim",
    ----------------------------------------
    -- Theme, Icons, Statusbar, Bufferbar --
    ----------------------------------------
    {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end,
    },
--    {
--        'ellisonleao/gruvbox.nvim',
--        config = function()
--            require('plugconfig.gruvbox')
--        end,
--    },
    {
        'tanvirtin/monokai.nvim',
        config = function()
            require('plugconfig.monokai')
        end,
    },
    { "nvim-lualine/lualine.nvim",
        config = function()
            require('plugconfig.lualine')
        end,
    },
    { "j-hui/fidget.nvim",


        config = function()
            require('fidget').setup()
        end,
    },
    ----------------
    -- Treesitter --
    ----------------
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'CursorHold',
        config = function()
            require('plugconfig.treesitter')
        end,
    },
    { 'nvim-treesitter/playground' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'nvim-treesitter/nvim-treesitter-refactor' },
    { 'windwp/nvim-ts-autotag' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },

    ---------------------------------
    -- Navigation and Fuzzy Search --
    ---------------------------------
    {
        'kyazdani42/nvim-tree.lua',
        event = 'CursorHold',
        config = function()
            require('plugconfig.nvim-tree')
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        event = 'CursorHold',
        lazy = false,
        config = function()
            require('plugconfig.telescope')
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        config = function()
            require('telescope').load_extension('fzf')
        end,
        build = 'make',
        lazy = false
    },
    { 'nvim-telescope/telescope-symbols.nvim' },
    --------------------------
    -- Editor UI Niceties --
    --------------------------
    { "lewis6991/gitsigns.nvim",
        event = 'BufRead',
        config = function()
            require('plugconfig.gitsigns')
        end,
    },
    { "ThePrimeagen/harpoon",
        config = function()
            require('plugconfig.harpoon')
        end,
    },
    {   "liuchengxu/vista.vim",
        config = function()
            require('plugconfig.vista')
        end,
    },
    {
        'numToStr/FTerm.nvim',
        event = 'CursorHold',
        config = function()
            require('plugconfig.fterm')
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('plugconfig.indent-blankline')
        end,
    },

    -----------------------------------
    -- LSP, Completions and Snippets --
    -----------------------------------
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufRead',
        config = function()
            require('plugconfig.lsp.null-ls')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = 'BufRead',
        config = function()
            require('plugconfig.lsp.servers')
        end,
    },
    {
        'rafamadriz/friendly-snippets',
        event = 'CursorHold',
    },
    {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        config = function()
            require('plugconfig.lsp.luasnip')
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            require('plugconfig.lsp.nvim-cmp')
        end,
    },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    {
        'andweeb/presence.nvim',
        config = function()
            require('plugconfig.presence')
    end,
    },
    {
        'folke/trouble.nvim',
        event = 'InsertEnter',
        config = function()
            require('plugconfig.trouble')
        end,
    },
    {
        'kdheepak/lazygit.nvim',
        config = function()
            require('plugconfig.lazygit')
        end,
    },

    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    }
})
