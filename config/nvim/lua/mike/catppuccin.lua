local catppuccin = require 'catppuccin'

local function config()
    catppuccin.setup({
        flavour = 'macchiato',
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

    vim.cmd.colorscheme "catppuccin-macchiato"
end

return {
    config = config,
}
