return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'},

    keys = {
        {'<leader>p', function()
                require('telescope.builtin').find_files()
            end, mode="n"},

        -- {'<leader>z', function()
        --         require('telescope.builtin').buffers()
        --     end, mode="n"},

        {'<leader>ä', function()
                require('telescope.builtin').live_grep({})
            end, mode="n"},

        {'<leader>d', function()
                require('telescope.builtin').diagnostics()
            end, mode="n"},

        {'<leader>k', function()
                require('telescope.builtin').keymaps()
            end, mode="n"},

        {'<leader>rr', function()
                require('telescope.builtin').lsp_references()
            end, mode="n"},

        {'<leader><leader>e', function()
                require "todo-comments"
                vim.cmd.TodoTelescope()
            end, mode="n"},

        {'<c-s>', function()
                require("telescope.builtin").spell_suggest(
                    require("telescope.themes").get_cursor({}))
        end, mode="n"},
    }
}
