local git_worktree = require 'git-worktree'
local telescope = require('telescope')
local map = vim.keymap.set

local function init()
    git_worktree.setup({
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        autopush = true,
    })

    telescope.load_extension('git_worktree')

    map('n', '<leader>gg', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
        { desc = 'List worktrees' })
    map('n', '<leader>gw', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
        { desc = 'Create worktree' })
end

return {
    init = init
}
