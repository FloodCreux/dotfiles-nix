local function config()
    local gitworktree = require 'git-worktree'

    gitworktree.setup({
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        autopush = true,
    })
end


return {
    config = config,
}
