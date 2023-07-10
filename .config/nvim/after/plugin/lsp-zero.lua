local lsp = require 'lsp-zero'
local cnf = require 'lspconfig'
local cmp = require('cmp')

lsp.preset('recommended')

vim.diagnostic.config({
    virtual_text = true,
})

local cmp_mappings = lsp.defaults.cmp_mappings()

-- confirm completion with tab
cmp_mappings['<Tab>'] = cmp.mapping.confirm({ select = true })
-- disable completion with return
cmp_mappings['<CR>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)


lsp.setup()

-- `pyright`: LSP from MS, to be abandoned in favor for pylance
-- require'lspconfig'.pyright.setup{}
-- `pylint`: very slow
cnf.pylsp.setup{}
cnf.dockerls.setup{}
cnf.clangd.setup{}
cnf.cmake.setup{}
