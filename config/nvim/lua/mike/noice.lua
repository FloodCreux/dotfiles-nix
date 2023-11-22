local function init()
    local noice = require 'noice'
    local notify = require 'notify'

    notify.setup({
        stages = 'fade',
        timeout = 500,
        background_colour = '#000000',
    })

    noice.setup({
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            hover = {
                enabled = true,
                silent = false,
                view = nil,
                opts = {},
            },
            documentation = {
                view = 'hover',
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        views = {
            cmdline_popup = {
                position = {
                    row = "50%",
                    col = "50%",
                },
            },
        },
    })
end

return {
    init = init,
}
