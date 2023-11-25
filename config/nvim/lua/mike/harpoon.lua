
local function init()
    local harpoon_mark = require 'harpoon.mark'
    local harpoon_ui = require 'harpoon.ui'
    local harpoon_cmd_ui = require 'harpoon.cmd-ui'

    vim.keymap.set('n', '<leader>ha', harpoon_mark.add_file, { desc = '[H]arpoon [A]dd File' })
    vim.keymap.set('n', '<leader>hm', harpoon_ui.toggle_quick_menu, { desc = '[H]arpoon Toggle [M]enu' })
    vim.keymap.set('n', '<leader>hh', function()
        harpoon_ui.nav_file(1)
    end, { desc = '[H]arpoon File 1' })

    vim.keymap.set('n', '<leader>hj', function()
        harpoon_ui.nav_file(2)
    end, { desc = '[H]arpoon File 2' })

    vim.keymap.set('n', '<leader>hk', function()
        harpoon_ui.nav_file(3)
    end, { desc = '[H]arpoon File 3' })

    vim.keymap.set('n', '<leader>hl', function()
        harpoon_ui.nav_file(4)
    end, { desc = '[H]arpoon File 4' })

    vim.keymap.set('n', '<leader>hn', function()
        harpoon_ui.nav_next()
    end, { desc = 'Next' })

    vim.keymap.set('n', '<leader>hp', function()
        harpoon_ui.nav_prev()
    end, { desc = 'Previous' })

    vim.keymap.set('n', '<leader>hc', function()
        harpoon_cmd_ui.toggle_quick_menu()
    end, { desc = 'Command UI' })

    vim.keymap.set('n', '<leader>hra', function()
        harpoon_mark.clear_all()
    end, { desc = 'Remove all' })
end

return {
    init = init,
}
