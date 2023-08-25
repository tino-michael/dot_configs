return {
    {
        'williamboman/mason.nvim',

        opts = {
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = "󰄳 ",
                    package_uninstalled = " 󰚌",
                },

                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "X",
                    cancel_installation = "<C-c>",
                },
            },

            max_concurrent_installers = 10,
        },
    },

    {
        'williamboman/mason-lspconfig.nvim',

        config = function()
            require("mason").setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    -- `pyright`: LSP from MS, to be abandoned in favor for pylance
                    -- `pylint`: very slow
                    'pylsp',
                    'bashls',
                    'lua_ls',
                    'clangd',
                    'rust_analyzer',
                },
            })
        end,
    },
}
