return {
    {
        -- File browsing panel
        'nvim-tree/nvim-tree.lua',

        -- enabled = false,
        -- lazy = false,

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
            {"<M-m>", vim.cmd.NvimTreeFocus, mode="n"},
        },

        config = {
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
                number = true,
                relativenumber = true,
                mappings = {
                    -- custom_only = true,
                    list = {
                        { key = "+", action = "cd" },
                    },
                },
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
}
