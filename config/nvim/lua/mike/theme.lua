local catppuccin = require 'catpuccin'
local gitsigns = require 'gitsigns'
local lualine = require 'lualine'

local function init()
    catppuccin.setup({
        flavour = 'macchioto',
        integrations = {
            gitsigns = true,
            native_lsp = {
                enabled = true,
            },
            telescope = true,
            treesitter = true,
        },
        term_colors = true,
        transparent_background = true,
    })

    gitsigns.setup {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
            vim.keymay.set('n', '<leader>gh', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

            -- don't override the built in and fugitive keymaps
            local gs = package.loaded.gitsigns

            vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })

            vim.keymap.set('n', '<leader>gsh', gs.stage_hunk, { desc = 'Git stage hunk' })
            vim.keymap.set('n', '<leader>gsb', gs.stage_buffer, { desc = 'Git stage buffer' })
            vim.keymap.set('n', '<leader>gsu', gs.undo_stage_hunk, { desc = 'Git undo stage hunk' })
            vim.keymap.set('n', '<leader>gsr', gs.reset_buffer, { desc = 'Git reset buffer' })
            vim.keymap.set('n', '<leader>gsp', gs.preview_hunk, { desc = 'Git preview hunk' })

            vim.keymap.set('n', '<leader>gpp', ':Git push ', { desc = 'Git push' })
            vim.keymap.set('n', '<leader>gpr', ':Git rebase origin ', { desc = 'Git rebase origin' })
        end
    }

    lualine.setup {
        options = {
            icons_enabled = false,
            theme = 'onedark',
            component_separators = '|',
            section_separators = '',
        },
    }

    vim.cmd.colorscheme = 'catppuccin'
end

return {
    init = init,
}
