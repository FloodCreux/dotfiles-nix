local function config()
    require('ibl').setup({
        exclude = {
            buftypes = { 'dashboard', '', 'lspinfo', 'mason', 'checkhealth', 'help' }
        },
    })
end

return {
    config = config,
}
