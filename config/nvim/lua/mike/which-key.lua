local function init()
    local wk = require 'which-key'
    wk.register({
        ['<leader>b'] = { name = 'Debug', _ = 'which_key_ignore' },
        ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Harpoon', _ = 'which_key_ignore' },
        ['<leader>m'] = { name = 'Metals', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = 'Terminal', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
    })
end


return {
    init = init,
}
