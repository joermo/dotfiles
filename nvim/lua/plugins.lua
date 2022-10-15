local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
    ---------------------
    -- Package Manager --
    ---------------------
    use('wbthomason/packer.nvim')
    ----------------------
    -- Required plugins --
    ----------------------
    use('nvim-lua/plenary.nvim')
    ----------------------------------------
    -- Theme, Icons, Statusbar, Bufferbar --
    ----------------------------------------
    use({
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end,
    })
    use({
        'ellisonleao/gruvbox.nvim',
        config = function()
            require('plugconf.gruvbox')
        end,

    })
    use({
        {
            'nvim-lualine/lualine.nvim',
            after = 'gruvbox.nvim',
            event = 'BufEnter',
            config = function()
                require('plugconf.lualine')
            end,
        },
        {
            'j-hui/fidget.nvim',
            after = 'lualine.nvim',
            config = function()
                require('fidget').setup()
            end,
        },
    })
    ----------------
    -- Treesitter --
    ----------------
    use({
        {
            'nvim-treesitter/nvim-treesitter',
            event = 'CursorHold',
            run = ':TSUpdate',
            config = function()
                require('plugconf.treesitter')
            end,
        },
        { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
        { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
        { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
    })
    ---------------------------------
    -- Navigation and Fuzzy Search --
    ---------------------------------
    use({
        'kyazdani42/nvim-tree.lua',
        event = 'CursorHold',
        config = function()
            require('plugconf.nvim-tree')
        end,
    })
    use({
        {
            'nvim-telescope/telescope.nvim',
            event = 'CursorHold',
            config = function()
                require('plugconf.telescope')
            end,
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            after = 'telescope.nvim',
            run = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
        {
            'nvim-telescope/telescope-symbols.nvim',
            after = 'telescope.nvim',
        },
    })
    --------------
    -- Terminal --
    --------------
    use({
        'numToStr/FTerm.nvim',
        event = 'CursorHold',
        config = function()
            require('plugconf.fterm')
        end,
    })
    --------------------------
    -- Editor UI Niceties --
    --------------------------
    use({
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require('plugconf.indentline')
        end,
    })

    use({
        'norcalli/nvim-colorizer.lua',
        event = 'CursorHold',
        config = function()
            require('colorizer').setup()
        end,
    })
    use({
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('plugconf.gitsigns')
        end,
    })

    use({
        'rhysd/git-messenger.vim',
        event = 'BufRead',
        config = function()
            require('plugconf.git-messenger')
        end,
    })

    -----------------------------------
    -- LSP, Completions and Snippets --
    -----------------------------------
    use({
        'neovim/nvim-lspconfig',
        event = 'BufRead',
        config = function()
            require('plugconf.lsp.servers')
        end,
        requires = {
            {
                -- WARN: Unfortunately we won't be able to lazy load this
                'hrsh7th/cmp-nvim-lsp',
            },
        },
    })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufRead',
        config = function()
            require('plugconf.lsp.null-ls')
        end,
    })

    use({
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            config = function()
                require('plugconf.lsp.nvim-cmp')
            end,
            requires = {
                {
                    'L3MON4D3/LuaSnip',
                    event = 'InsertEnter',
                    config = function()
                        require('plugconf.lsp.luasnip')
                    end,
                    requires = {
                        {
                            'rafamadriz/friendly-snippets',
                            event = 'CursorHold',
                        },
                    },
                },
            },
        },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    })

    -- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
    use({
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        after = 'nvim-cmp',
        config = function()
            require('plugconf.pairs')
        end,
    })





    if packer_bootstrap then
        require('packer').sync()
    end
end)
