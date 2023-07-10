return {

    -- Insert or delete brackets, parens, quotes in pair.
    {'jiangmiao/auto-pairs', config=function()
            vim.g.AutoPairsMultilineClose=0
        end
    },

    -- VCS indicators
    'mhinz/vim-signify',

    -- csv helper
    'chrisbra/csv.vim',
    -- sum values in visual mode
    'sk1418/HowMuch',
}
