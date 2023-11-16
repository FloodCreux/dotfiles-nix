local wk = require 'which-key'

local function init()
    wk.register({
        ['<leader>b'] = { name = 'Debug', _ = 'which_key_ignore' }
    })
end


return {
    init = init,
}
