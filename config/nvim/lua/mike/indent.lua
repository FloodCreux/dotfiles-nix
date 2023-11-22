local function config()
    local indent = require('ibl')
    indent.setup({
        exclude = {
            buftypes = { 'dashboard', '', 'lspinfo', 'mason', 'checkhealth', 'help' }
        }
    })
end

return {
    config = config,
}
