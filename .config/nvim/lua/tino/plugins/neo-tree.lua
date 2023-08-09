return {
    -- File browsing panel
    "nvim-neo-tree/neo-tree.nvim",

    -- enabled = false,

    branch = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    keys = {
        -- toggles neo-tree open/closed
        {"<leader>b", [[:Neotree toggle<CR>]], mode="n"},

        -- find and focus on current file, open tree if necessary
        {"<M-b>", [[:Neotree reveal reveal_force_cwd<CR>]], mode="n"},
        -- focus on tree, open if necessary
        {"<M-m>", [[:Neotree focus<CR>]], mode="n"},

        {"gs", [[:Neotree git_status float<CR>]], mode="n"},
    },

    opts = {
        default_component_configs = {
            git_status = {
                symbols = {
                  -- Change type
                  added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                  modified  = "~", -- or "", but this is redundant info if you use git_status_colors on the name
                  deleted   = "⨯",-- this can only be used in the git_status source
                  renamed   = "󰁕",-- this can only be used in the git_status source
                  -- Status type
                  untracked = "",
                  ignored   = "",
                  unstaged  = "󰄱",
                  staged    = "",
                  conflict  = "",
                }
            },
        },

        window = {
            mappings = {
                ["o"] = "open",
                ["e"] = "open",
            }
        }
    }
}
