return {
    'lewis6991/gitsigns.nvim',

    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        current_line_blame = false,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            map('n', '<leader>gd', gs.toggle_deleted)
            map('n', '<leader>gf', gs.stage_buffer)
            map('n', '<leader>ga', gs.stage_hunk)
            map('n', '<leader>gu', gs.undo_stage_hunk)
            map('n', '<leader>rh', gs.reset_hunk)

            map('v', '<leader>ga', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        end
    }
}
