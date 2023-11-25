local function config()
    require('indent_blankline').setup({
        exclude = {
            buftypes = { 'dashboard', '', 'lspinfo', 'mason', 'checkhealth', 'help' }
        },
    })
end

return {
    config = config,
}
