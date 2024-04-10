local autocmd = vim.api.nvim_create_autocmd
local grp = vim.api.nvim_create_augroup("autocmd_grp", { clear = true })

-- spell-checking certain file types (toggle locally with leader-s)
autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell", group = grp }
)

-- auto delete trailing whitespace and newlines at end of file on save.
autocmd(
    { "BufWritePre" },
    { command = [[let currPos = getpos(".")]], group = grp }
)
autocmd(
    { "BufWritePre" },
    { command = [[ %s/\s\+$//e ]], group = grp }
)
autocmd(
    { "BufWritePre" },
    { command = [[ %s/\n\+\%$//e ]], group = grp  }
)
autocmd(
    { "BufWritePre" },
    { command = [[ cal cursor(currPos[1], currPos[2]) ]], group = grp  }
)

-- Update polybar when config is updated.
autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/polybar/config" },
        command = [[ !pkill -USR1 polybar ]],
        group = grp
    }
)

-- Update mpd when config is updated.
autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/mpd.conf" },
        command = [[ !pkill -15 mpd && mpd ]],
        group = grp
    }
)

-- reread xresources when config is updated
autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/xresources" },
        command = [[ !xrdb % ]],
        group = grp
    }
)

-- restart waybar when config files are changed
autocmd(
    { "BufWritePost" },
    {
        pattern = { "*/waybar/*" },
        command = [[ ! killall waybar; waybar & ]],
        group = grp
    }
)

-- clear latex auxiliary files when leaving a .tex file
autocmd(
    { "VimLeave" },
    {
        pattern = { "*.tex" },
        command = [[ !texclear % ]],
        group = grp
    }
)


-- auto arranges specific csv files
local grp = vim.api.nvim_create_augroup("csv_group", { clear = true })

autocmd(
    { "BufRead", "BufWritePost" },
    {
        pattern = { "*.csv" },
        command = [[:RainbowAlign]],
        group = grp
    }
)

autocmd(
    { "BufWritePre" },
    {
        pattern = { "*.csv" },
        command = [[:RainbowShrink]],
        group = grp
    }
)
