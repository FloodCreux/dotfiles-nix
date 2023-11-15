local function set_vim_g()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
end

local function set_vim_o()
    local settings = {
        clipboard = 'unnamedplus',
        expandtab = true,
        scrolloff = 8,
        shiftwidth = 4,
        softtabstop = 4,
        tabstop = 4,
        termguicolors = true,
        hlsearch = false,
        mouse = 'a',
        breakindent = true,
        undofile = true,
        ignorecase = true,
        smartcase = true,
        updatetime = 250,
        timeoutlen = 300,
        smartindent = true,
        smarttab = true
    }

    for k, v in pairs(settings) do
        vim.o[k] = v
    end

    vim.cmd("set colorcolumn=120")
end

local function set_vim_wo()
    local settings = {
        number = true,
        relativenumber = true,
        signcolumn = 'yes',
        wrap = false,
    }

    for k, v in pairs(settings) do
        vim.wo[k] = v
    end
end

local function set_vim_opt()
    vim.opt.nu = true
end

local function set_vim_keymaps()
    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
    vim.keymap.set("n", "<leader>Y", [["+Y]])

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = '[F]or[M]at current file' })

    vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

    vim.keymap.set("x", "<leader>p", [["_dP]])

    vim.keymap.set('n', '<leader>x', ":q<CR>", { desc = "Close current buffer" })

    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = '*',
    })

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>om', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    vim.keymap.set('n', '<leader>od', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
end

local function init()
    set_vim_g()
    set_vim_o()
    set_vim_wo()
    set_vim_opt()
    set_vim_keymaps()
end

return {
    init = init,
}
