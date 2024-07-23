-- go to last active buffer
vim.keymap.set("n", "<c-q>", "<c-6>")

-- space in non-edit mode doesn't advance cursor
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- move lines up / down
vim.keymap.set("n", "<S-A-r>", ":m .+1<CR>==")
vim.keymap.set("n", "<S-A-n>", ":m .-2<CR>==")
vim.keymap.set("i", "<S-A-r>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<S-A-n>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<S-A-r>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-A-n>", ":m '<-2<CR>gv=gv")

-- append line below to current line without moving cursor
vim.keymap.set("n", "J", "mzJ`z")
-- jump half-page up and down, keep cursor center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- search forward / backward, keep cursor center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over highlight without losing buffer
vim.keymap.set({"x", "v"}, "<A-p>", [["_dP]])

-- yank to and paste from system clipboard
vim.keymap.set("n", "<C-y>", [[<S-v>"+y]])
vim.keymap.set("v", "<C-y>", [["+y]])
vim.keymap.set({"n", "v"}, "<C-p>", [["+p]])
vim.keymap.set("i", "<C-p>", [[<esc>"+Pi]])

-- make current file executable `chmod +x`
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- execute current file (make sure interpreter is set in she-bang)
vim.keymap.set("n", "<s-x>", [[:! %<cr>]])

-- split buffer navigation
vim.keymap.set("n", "<A-d>", "<C-W><C-L>")
vim.keymap.set("n", "<A-n>", "<C-W><C-H>")
vim.keymap.set("n", "<A-t>", "<C-W><C-J>")
vim.keymap.set("n", "<A-r>", "<C-W><C-K>")
vim.keymap.set("n", "<leader>e", "<C-W><C-L>")
vim.keymap.set("n", "<leader>i", "<C-W><C-H>")
vim.keymap.set("n", "<leader>a", "<C-W><C-J>")
vim.keymap.set("n", "<leader>l", "<C-W><C-K>")

-- equalise widths and heights of all panes
vim.keymap.set("n", "<leader>f", "<C-W>=")

-- indent with tab in normal mode
vim.keymap.set("n", "<tab>", ">>")
vim.keymap.set("n", "<s-tab>", "<<")
-- indent in visual mode keeps visual selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- go to last active tab
vim.g.last_tab = 1
vim.api.nvim_create_autocmd(
    { "TabLeave" },
    {
        pattern = "*",
        callback = function()
            vim.g.last_tab = vim.api.nvim_tabpage_get_number(0)
            vim.api.nvim_set_keymap(
                'n', '<leader>tt', ':tabn ' .. vim.g.last_tab .. '<CR>',
                { noremap = true, silent = true })
        end
    }
)
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew)
vim.keymap.set("n", "<leader>td", vim.cmd.tabclose)

-- go to tab by number
vim.keymap.set("n", "<leader>t1", "1gt")
vim.keymap.set("n", "<leader>t2", "2gt")
vim.keymap.set("n", "<leader>t3", "3gt")
vim.keymap.set("n", "<leader>t4", "4gt")
vim.keymap.set("n", "<leader>t5", "5gt")
vim.keymap.set("n", "<leader>t6", "6gt")
vim.keymap.set("n", "<leader>t7", "7gt")
vim.keymap.set("n", "<leader>t8", "8gt")
vim.keymap.set("n", "<leader>t9", "9gt")
vim.keymap.set("n", "<leader>t0", vim.cmd.tablast)

-- unfold
vim.keymap.set("n", "<c-f>", "za")

-- toggle spell checking
vim.keymap.set("n", "<leader>s", [[:setlocal spell!<cr>]])
