local function init()
    local telescope = require('telescope')
    local map = vim.keymap.set
    telescope.load_extension('git_worktree')

    map('n', '<leader>gg', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
        { desc = 'List worktrees' })
    map('n', '<leader>gw', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
        { desc = 'Create worktree' })
end

local function worktree()
    local gitworktree = require 'git-worktree'

    gitworktree.setup({
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        autopush = true,
    })
end

local function gitsigns()
    local gitsigns = require 'gitsigns'

    gitsigns.setup({
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
            vim.keymap.set('n', '<leader>gh', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

            -- don't override the built in and fugitive keymaps
            local gs = package.loaded.gitsigns

            vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })

            vim.keymap.set('n', '<leader>gsh', gs.stage_hunk, { desc = 'Git stage hunk' })
            vim.keymap.set('n', '<leader>gsb', gs.stage_buffer, { desc = 'Git stage buffer' })
            vim.keymap.set('n', '<leader>gsu', gs.undo_stage_hunk, { desc = 'Git undo stage hunk' })
            vim.keymap.set('n', '<leader>gsr', gs.reset_buffer, { desc = 'Git reset buffer' })
            vim.keymap.set('n', '<leader>gsp', gs.preview_hunk, { desc = 'Git preview hunk' })

            vim.keymap.set('n', '<leader>gpp', ':Git push ', { desc = 'Git push' })
            vim.keymap.set('n', '<leader>gpr', ':Git rebase origin ', { desc = 'Git rebase origin' })
        end
    })
end

return {
    init = init,
    worktree = worktree,
    gitsigns = gitsigns,
}
