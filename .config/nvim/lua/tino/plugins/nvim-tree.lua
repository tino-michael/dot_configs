return {
    -- File browsing panel
    'nvim-tree/nvim-tree.lua',


    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    keys = {
        -- toggles nvimtree open/closed
        {"<leader>bb", vim.cmd.NvimTreeToggle, mode="n"},

        -- focuses on nvimtree, opens if necessary
        -- {"<leader>bt", vim.cmd.NvimTreeFocus, mode="n"},

        -- finds the current file in nvimtree, marking it; opens tree if necessary
        {"<leader>bc", vim.cmd.NvimTreeFindFile, mode="n"},
        -- {"<M-b>", [[: lua require('nvim-tree.api').tree.toggle({ path = vim.api.nvim_buf_get_name(0)})<cr>]], mode="n"},
    },

    opts = {
        on_attach = on_attach,
        view = {
            adaptive_size = false,
            width = 35,
            number = true,
            relativenumber = true,
        },
        filesystem_watchers = {
            enable = true
        },
        renderer = {
            group_empty = true,
            icons = {
                glyphs = {
                    folder = {
                        arrow_closed = "⏵",
                        arrow_open = "⏷",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        filters = {
            custom = {
                '__pycache__',
                '.egg-info',
            },
        },
    }
}
