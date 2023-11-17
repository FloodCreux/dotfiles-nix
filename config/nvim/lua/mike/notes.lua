local neorg = require 'neorg'
local map = vim.keymap.set

local function init()
    neorg.setup {
        load = {
            ['core.defaults'] = {},
            ['core.concealer'] = {},
            ['core.summary'] = {},
            ['core.completion'] = {
                config = {
                    engine = 'nvim-cmp'
                },
            },
            ['core.dirman'] = {
                config = {
                    workspaces = {
                        work = '~/notes/work',
                        personal = '~/notes/personal'
                    },
                },
            },
        },
    }

    map('n', '<leader>nww', ':Neorg workspace work<CR>', { desc = 'Open work notes workspace' })
    map('n', '<leader>nwp', ':Neorg workspace personal<CR>', { desc = 'Open work notes workspace' })
end

return {
    init = init,
}
