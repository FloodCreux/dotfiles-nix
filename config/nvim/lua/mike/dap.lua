local function init()
    local dap = require 'dap'
    local dapui = require 'dapui'

    vim.keymap.set('n', '<leader>bs', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>bi', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>bo', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>eu', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>BB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
            icons = {
                pause = '⏸',
                play = '▶',
                step_into = '⏎',
                step_over = '⏭',
                step_out = '⏮',
                step_back = 'b',
                run_last = '▶▶',
                terminate = '⏹',
                disconnect = '⏏',
            },
        },
    }

    vim.keymap.set('n', '<leader>bl', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' },
    }

    dap.adapters.netcoredbg = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
        {
            type = 'coreclr',
            name = 'launch - netcoredbg',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/src', 'file')
            end
        },
    }
end

return {
    init = init,
}
