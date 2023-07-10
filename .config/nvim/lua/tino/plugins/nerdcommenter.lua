return {
    -- comment toggler
    'preservim/nerdcommenter',
    config = function()
        -- Add spaces after comment delimiters when toggling comments
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDDefaultAlign = 'left'
    end
}
