local dashboard = require 'dashboard'

function init()
    vim.g.dashboard_default_executive = 'telescope'

    local logo = {
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
                { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
                {
                    action = 'lua require("persistence").load()',
                    desc = " Restore Session",
                    icon = " ",
                    key = "s"
                },
                { action = "qa", desc = " Quit", icon = " ", key = "q" },
            },
            footer = ''
        },
    })
end

return {
    init = init,
}
