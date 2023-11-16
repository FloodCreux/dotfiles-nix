local neorg = require 'neorg'

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
end

return {
    init = init,
}
