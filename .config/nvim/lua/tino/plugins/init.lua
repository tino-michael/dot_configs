return {

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
        keys = {
        }
    },

    -- csv helper
    'chrisbra/csv.vim',
    -- sum values in visual mode
    'sk1418/HowMuch',
}
