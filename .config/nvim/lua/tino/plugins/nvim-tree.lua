return {
    -- File browsing panel
    'nvim-tree/nvim-tree.lua',

    enabled = false,

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    keys = {
        -- toggles nvimtree open/closed
        {"<leader>b", vim.cmd.NvimTreeToggle, mode="n"},

        -- focuses on nvimtree, opens if necessary
        {"<leader>m", vim.cmd.NvimTreeFocus, mode="n"},

        -- finds the current file in nvimtree, marking it; opens tree if necessary
        {"<M-b>", vim.cmd.NvimTreeFindFile, mode="n"},
        -- {"<M-b>", [[: lua require('nvim-tree.api').tree.toggle({ path = vim.api.nvim_buf_get_name(0)})<cr>]], mode="n"},


        {"<M-m>", vim.cmd.NvimTreeFocus, mode="n"},
    },

    opts = {
        on_attach = on_attach,
        sort_by = "case_sensitive",
        view = {
            adaptive_size = false,
            number = true,
            relativenumber = true,
        },
        renderer = {
            group_empty = true,
            icons={
                glyphs = {
                    folder = {
                        arrow_closed = "⏵",
                        arrow_open = "⏷",
                    }
                }
            }
        },
        filters = {
            custom = {
                '__pycache__',
                '.egg-info',
            },
        },
    }
}
