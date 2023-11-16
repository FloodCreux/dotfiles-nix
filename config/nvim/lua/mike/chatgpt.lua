local chatgpt = require 'chatgpt'

local function init()
    local api_key_cmd = 'pass show api/tokens/openai'

    chatgpt.setup({
        api_key_cmd = api_key_cmd,
    })

    local map = vim.keymap.set

    map('n', '<leader>jj', ':ChatGPT<CR>', { desc = 'Open ChatGPT' })
    map({ 'n', 'v' }, '<leader>jo', ':ChatGPTRun optimize_code<CR>', { desc = 'Optimize code' })
    map({ 'n', 'v' }, '<leader>je', ':ChatGPTRun explain_code<CR>', { desc = 'Explain code' })
end

return {
    init = init
}
