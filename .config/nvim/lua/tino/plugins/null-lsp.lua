return {
    -- TODO: configure
    -- basic fallback language server
    'jose-elias-alvarez/null-ls.nvim',

    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.luacheck,
                null_ls.builtins.diagnostics.pydocstyle,
                null_ls.builtins.diagnostics.stylelint,
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.completion.luasnip,
            },
        })
    end
}
