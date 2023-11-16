local dashboard = require 'dashboard'

local function init()
    vim.g.dashboard_default_executive = 'telescope'

    local logo = {
        [[                              ]],
        [[⠀⠀⠀⠀⣀⣀⣤⣤⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⡄⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠛⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⣿⡟⠡⠂⠀⢹⣿⣿⣿⣿⣿⣿⡇⠘⠁⠀⠀⣿⡇⠀⢠⣄⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⢸⣗⢴⣶⣷⣷⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣴⣿⣗⣄⣼⣷⣶⡄⠀⠀]],
        [[⠀⠀⠀⢀⣾⣿⡅⠐⣶⣦⣶⠀⢰⣶⣴⣦⣦⣶⠴⠀⢠⣿⣿⣿⣿⣿⣿⡇⠀⠀]],
        [[⠀⠀⢀⣾⣿⣿⣷⣬⡛⠷⣿⣿⣿⣿⣿⣿⣿⠿⠿⣠⣿⣿⣿⣿⣿⠿⠛⠀⠀⠀]],
        [[⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣶⣦⣭⣭⣥⣭⣵⣶⣿⣿⣿⣿⡟⠉⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠙⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣛⠛⠛⠛⠛⠛⢛⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠿⣿⣿⣿⠿⠿⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠿⠇⠀  ⠀⠀⠀⠀]],
        [[                              ]],
        [[  There is no place like ~/   ]],
        [[                              ]],
    }

    dashboard.setup({
        theme = 'doom',
        hide = {
            statusline = false,
            tabline,
        },
        config = {
            header = logo,
            center = {
                { action = "Telescope find_files", desc = " Find file",    icon = " ", key = "f" },
                { action = "ene | startinsert",    desc = " New file",     icon = " ", key = "n" },
                { action = "Telescope oldfiles",   desc = " Recent files", icon = " ", key = "r" },
                { action = "Telescope live_grep",  desc = " Find text",    icon = " ", key = "g" },
                { action = "e $MYVIMRC",           desc = " Config",       icon = " ", key = "c" },
                { action = "qa",                   desc = " Quit",         icon = " ", key = "q" },
            },
            footer = {}
        },
    })
end

return {
    init = init,
}
