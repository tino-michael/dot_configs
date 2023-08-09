local lsp = require 'lsp-zero'
local cnf = require 'lspconfig'
local cmp = require 'cmp'

local mason = require 'mason'
local mason_lsp = require 'mason-lspconfig'




-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(0, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(0, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    -- show signature / docstring of element under cursor
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- show signature of function call while *within* the function parameters
    buf_set_keymap("n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    -- smart word rename (intellisense)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    ----------------------- Diagnostics -----------------------
    buf_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
    -- buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- this makes use of the TroubleToggle plugin but still fits into this lsp ecosystem
    -- buf_set_keymap("n", "<leader>dt", "<cmd>TroubleToggle<CR>", opts)
end


mason.setup()
mason_lsp.setup {
    ensure_installed = {
        -- `pyright`: LSP from MS, to be abandoned in favor for pylance
        -- `pylint`: very slow
        'pylsp',
        'bashls',
        'lua_ls',
        'clangd',
        'rust_analyzer',
    },
}


mason_lsp.setup_handlers {
    function(server_name)
        cnf[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,

    ["lua_ls"] = function()
        cnf["lua_ls"].setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                        disable = {"lowercase-global"},
                    },
                    hint = {
                        enable = true,
                    },
                },
            },
        })
    end,
}



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
