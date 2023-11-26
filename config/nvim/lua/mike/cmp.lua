local M = {}

M.dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- Adds autopairs
    {
        'windwp/nvim-autopairs',
        opts = {
            fast_wrap = {},
            disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts)
            require('nvim-autopairs').setup(opts)

            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
}


local function init()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local autopairs = require 'nvim-autopairs'
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    autopairs.setup {
        fast_wrap = {},
        disable_filetype = { 'TelescopePrompt', 'vim' },
    }

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
    }

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return {
    init = init,
    dependencies = M.dependencies,
}
