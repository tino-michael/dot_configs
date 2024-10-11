return {
    -- toggle line comments
    {
        'numToStr/Comment.nvim',
        opts = {
            toggler = {
                line = 'gcc',
            }
        },
        lazy = false,
    },

    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
    },

    -- Insert or delete brackets, parens, quotes in pair.
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        'folke/todo-comments.nvim',
        dependencies = {"nvim-lua/plenary.nvim"},
        event = "BufRead",
        opts = {},
        config = {
            keywords = {
                TODO = { icon = " ", color = "info" },
            },
        },
        keys = {}
    },

    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },

    -- sum values in visual mode
    'sk1418/HowMuch',
}
