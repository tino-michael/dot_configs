return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        {'neovim/nvim-lspconfig'},
    },

    lazy = false,

    keys = {
        {"<c-n>", vim.cmd.ClangdSwitchSourceHeader, mode="n"},
    },

    config = function()
        require "tino.plugins.configs.lsp-zero"
    end
}
