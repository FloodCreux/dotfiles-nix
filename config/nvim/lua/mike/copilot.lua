local function init()
    local copilot = require 'copilot'

    copilot.setup {
        suggestion = {
            auto_trigger = true,
        },
    }
end

return {
    init = init,
}
