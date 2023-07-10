return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'},

    keys = {
        {'<leader>p', function()
                require('telescope.builtin').find_files()
            end, mode="n"},

        {'<leader>z', function()
                require('telescope.builtin').buffers()
            end, mode="n"},

        {'<leader>ä', function()
                require('telescope.builtin').live_grep({})
            end, mode="n"},

        {'<leader>dd', function()
                require('telescope.builtin').diagnostics()
            end, mode="n"},

        {'<leader>k', function()
                require('telescope.builtin').keymaps()
            end, mode="n"}
    }
}
