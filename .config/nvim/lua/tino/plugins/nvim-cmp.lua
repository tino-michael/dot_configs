-- Autocompletion
return {
    'hrsh7th/nvim-cmp',

    dependencies = {
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {'saadparwaiz1/cmp_luasnip'},
        {'pontusk/cmp-sass-variables'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
    },

    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                -- Accept currently selected item. Set `select` to `false` to only
                -- confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp', keyword_length = 1 },
                { name = 'nvim_lsp_signature_helper' },
                { name = 'nvim_lua', keyword_length = 2 },
            }, {
                { name = 'buffer' },
                { name = 'path' },
                { name = 'git' },
                { name = 'crates' },
                { name = 'calc' },
            })
        })
    end,
}
