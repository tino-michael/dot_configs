return {
    -- highlight colour names and variables
    {
        'norcalli/nvim-colorizer.lua',
        enabled=false,
        config = function()
            require'colorizer'.setup()
        end,
    },

    'brenoprata10/nvim-highlight-colors',
}
