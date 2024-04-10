return {
    'chriskempson/base16-vim',

    -- color scheme
    {'catppuccin/vim', as = 'catppuccin'},

    priority = 1000,

    opt = function()
        color = "catppuccin_mocha"
        vim.cmd.colorscheme(color)
        vim.cmd[[highlight ColorColumn ctermbg=4]]
    end
}
