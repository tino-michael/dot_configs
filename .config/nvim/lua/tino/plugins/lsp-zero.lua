return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
    },

    keys = {
        {"<c-n>", vim.cmd.ClangdSwitchSourceHeader, mode="n"},
    },
}
