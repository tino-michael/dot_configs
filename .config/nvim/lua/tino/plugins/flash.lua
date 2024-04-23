return {
    "folke/flash.nvim",
    event = "VeryLazy",

    opts = {
        search = {
            -- only forward jumping
            forward = true, wrap = false, multi_window = false,
            -- only match beginning of word
            mode = function(str)
                return "\\<" .. str
            end,
        },
        highlight = {
            backdrop = false
        }
    },

    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
}
