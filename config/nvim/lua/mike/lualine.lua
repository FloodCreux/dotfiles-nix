local function init()
    local lualine = require 'lualine'
    lualine.setup {
        options = {
            icons_enabled = false,
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = '',
        },
    }
end

return {
    init = init,
}
