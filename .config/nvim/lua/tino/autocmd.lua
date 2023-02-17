local grp = vim.api.nvim_create_augroup("autocmd_grp", { clear = true })

-- spell-checking certain file types (toggle locally with leader-s)
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell", group = grp }
)

-- auto delete trailing whitespace and newlines at end of file on save.
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = [[let currPos = getpos(".")]], group = grp }
)
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = [[ %s/\s\+$//e ]], group = grp }
)
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = [[ %s/\n\+\%$//e ]], group = grp  }
)
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { command = [[ cal cursor(currPos[1], currPos[2]) ]], group = grp  }
)

-- Update polybar when config is updated.
vim.api.nvim_create_autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/polybar/config" },
        command = [[ !pkill -USR1 polybar ]],
        group = grp
    }
)

-- Update mpd when config is updated.
vim.api.nvim_create_autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/mpd.conf" },
        command = [[ !pkill -15 mpd && mpd ]],
        group = grp
    }
)

-- generate config files when their template changed
vim.api.nvim_create_autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/alacritty.yml.in", "*/dunstrc.in" },
        command = [[ !generate_xresource_configs ]],
        group = grp
    }
)

-- reread xresources when config is updated
vim.api.nvim_create_autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/xresources" },
        command = [[ !xrdb % ]],
        group = grp
    }
)

-- clear latex auxiliary files when leaving a .tex file
vim.api.nvim_create_autocmd(
    { "VimLeave" },
    {
        pattern = { "*.tex" },
        command = [[ !texclear % ]],
        group = grp
    }
)


-- auto arranges specific csv files
local grp = vim.api.nvim_create_augroup("csv_group", { clear = true })

vim.api.nvim_create_autocmd(
{ "BufRead", "BufWritePost" },
{
    pattern = { "*.csv" },
    command = [[:%ArrangeColumn]],
    group = grp
}
)

vim.api.nvim_create_autocmd(
{ "BufWritePre" },
{
    pattern = { "*.csv" },
    command = [[:%UnArrangeColumn]],
    group = grp
}
)
