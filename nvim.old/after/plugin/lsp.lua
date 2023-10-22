local lsp = require('lsp-zero')
local bind = vim.keymap.set

lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'gopls',
    'jdtls',
    'pyright',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    },
    virtual_text = false,
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    --bind("n", "gd", function() vim.lsp.buf.definition() end, opts)
    --bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    bind("n", "K", function() vim.lsp.buf.hover() end, opts)
    bind("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    bind("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    bind("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    bind("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    bind("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    bind("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    bind("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    bind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    cmd = { 'lua-language-server' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
})


lsp.setup()
