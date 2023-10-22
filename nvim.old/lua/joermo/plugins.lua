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
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf"
    },
    { "folke/neodev.nvim" },
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine'
    },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-treesitter/playground' },
    { 'theprimeagen/harpoon' },
    { 'mbbill/undotree' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    -- { "folke/neodev.nvim", opts = {} },
    { "kyazdani42/nvim-tree.lua" },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    { "tanvirtin/monokai.nvim" },
    { "numToStr/Comment.nvim" },
    { "ellisonleao/gruvbox.nvim",           priority = 1000 },
    { 'kdheepak/lazygit.nvim' },
    { "lukas-reineke/indent-blankline.nvim" },
    { "nvim-lualine/lualine.nvim" },
    {
        "mg979/vim-visual-multi",
        branch = "master"
    },
    {"voldikss/vim-floaterm"},
    {"numToStr/FTerm.nvim"},
})
