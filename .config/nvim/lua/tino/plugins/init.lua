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
    {'jiangmiao/auto-pairs', config=function()
            vim.g.AutoPairsMultilineClose=0
        end
    },

    {
        'folke/todo-comments.nvim',
        dependencies = {"nvim-lua/plenary.nvim"},
        event = "BufRead",
        opts = {},
        config = {},
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
