local M = {
    "catppuccin/nvim", name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            custom_highlights = function(colors)
                return {
                    ColorColumn = { bg = colors.red },
                }
            end,
            integrations = {
                gitsigns = true,
                neogit = true,
                nvimtree = true,
            },
        }
        vim.cmd.colorscheme("catppuccin")
    end
}


return M
