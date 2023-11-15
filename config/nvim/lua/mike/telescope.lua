local telescope = require 'telescope'

local function init()
    telescope.setup {
        defaults = {
            file_ignore_patterns = {
                'node_modules/.*',
                '%.pem',
            },
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
        extensions = {
            file_browser = {
                hijack_netrw = true,
                mappings = {
                    ['i'] = {},
                    ['n'] = {},
                },
            },
        },
        find_files = {
            hidden = true,
        },
    }

    telescope.load_extension('fzf')
    telescope.load_extension('file_browser')
    telescope.load_extension('metals')


    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files({ hidden = true }) end,
        { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
end

return {
    init = init
}
