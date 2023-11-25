local function init()
    local lualine = require 'lualine'
    lualine.setup {
        options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
        },
    }
end

return {
    init = init,
}
