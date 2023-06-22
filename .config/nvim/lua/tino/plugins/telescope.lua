return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'},

    keys = {
        {'<leader>p', function()
                require('telescope.builtin').find_files()
            end, mode="n"},

        -- {'<C-p>', builtin.git_files, mode="n"},

        {'<leader>ä', function()
                require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
            end, mode="n"},

        {'<leader>dd', function()
                require('telescope.builtin').diagnostics()
            end, mode="n"}
    }
}
