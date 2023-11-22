local function init()
    local telescope = require('telescope')
    local map = vim.keymap.set
    telescope.load_extension('git_worktree')

    map('n', '<leader>gg', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
        { desc = 'List worktrees' })
    map('n', '<leader>gw', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
        { desc = 'Create worktree' })
end

return {
    init = init
}
