function MyColors(color)
    color = color or "dracula"
	vim.cmd.colorscheme(color)

    -- sets the vertical ruler to the red of the terminal scheme
    vim.cmd[[highlight ColorColumn ctermbg=1]]

    -- would remove (i.e. make transparent) the background of the editor
    -- (terminal colours / transparencies still apply)
    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

MyColors()
