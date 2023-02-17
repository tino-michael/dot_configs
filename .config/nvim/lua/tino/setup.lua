vim.g.mapleader = " "

-- disable netrw at the very start of setup
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- set folding level super high
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- Set the terminal title to the current file
vim.opt.title = true
-- Highlight the line under the cursor
vim.opt.cursorline = true
-- wrap line on word boundaries
vim.opt.linebreak = true
--vim.opt.wrap = false


vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undotree"
vim.opt.undofile = true

-- Search configuration
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- ignore case when searching
vim.opt.ignorecase = true
-- turn on smartcase
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- keep that many rows to screen bottom/top while scrolling
vim.opt.scrolloff = 8
-- forces diagnostics gutter to stay open
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100,120"
vim.cmd[[highlight ColorColumn ctermbg=1]]

-- don't beep
vim.opt.visualbell = true
vim.opt.errorbells = false

-- detect changes to file outside of vim and read in changes
vim.opt.autoread = true

-- spell-checking
vim.opt.spelllang="en_us,de_de,en_gb,fr"
vim.opt.complete:append('kspell')


local grp = vim.api.nvim_create_augroup("lsp_document_format", { clear = true })

-- autosave buffers on focus loss
vim.api.nvim_create_autocmd(
    { "BufLeave", "FocusLost" },
    { command = "wa", group = grp }
)
