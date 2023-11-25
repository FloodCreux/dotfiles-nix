local function init()
    local copilot = require 'copilot'

    copilot.setup {
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = '<TAB>',
                dismiss = '<C-c>',
            },
        },
    }
end

return {
    init = init,
}
