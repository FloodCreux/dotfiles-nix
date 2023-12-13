local function init()
    local hover = require 'hover'

    hover.setup {
        init = function()
            require('hover.providers.lsp')
        end,
        preview_opts = {
            border = 'single',
        },
        preview_window = false,
        title = true,
        mouse_providers = {
            'LSP'
        },
        mouse_delay = 1000,
    }

    vim.keymap.set('n', 'K', hover.hover, { desc = 'Hover' })
    vim.keymap.set('n', 'gk', hover.hover_select, { desc = 'Hover Select' })

    -- vim.keymap.set('n', '<MouseMove>', hover.hover_mouse, { desc = 'Hover Mouse' })
    -- vim.o.mousemoveevent = true
end

return {
    init = init
}
