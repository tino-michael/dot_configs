return {
    "NeogitOrg/neogit",

    priority = 10,

    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },

    config = true,

    keys={
        {"<leader>gs", vim.cmd.Neogit, mode="n"},
    },
}
