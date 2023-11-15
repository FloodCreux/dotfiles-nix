local copilot = require 'copilot'
local lspconfig = require 'lspconfig'
local treesitter = require 'nvim-treesitter.configs'
local treesitter_context = require 'treesitter-context'

local function autocmd(args)
    local event = args[1]
    local group = args[2]
    local callback = args[3]

    vim.api.nvim_create_autocmd(event, {
        group = group,
        buffer = args[4],
        callback = function()
            callback()
        end,
        once = args.once,
    })
end

local function on_attach(client, buffer)
    local augroup_highlight = vim.api.nvim_create_autogroup("custom-lsp-references", { clear = true })
    local autocmd_clear = vim.api.nvim_clear_autocmds

    local opts = { buffer = buffer, remap = false }

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = buffer, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

    nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    if client.server_capabilities.documentHighlightProvider then
        autocmd_clear { group = augroup_highlight, buffer = buffer }
        autocmd { 'CursorHold', augroup_highlight, vim.lsp.buf.document_highlight, buffer }
        autocmd { 'CursorMove', augroup_highlight, vim.lsp.buf.clear_references, buffer }
    end
end

local function init()
    copilot.setup {
        suggestion = {
            auto_trigger = true,
        },
    }

    local language_servers = {
        csharp_ls = {},
        diagnosticls = {
            filetypes = { 'python' },
            init_options = {
                filetypes = {
                    python = 'black',
                },
                formatFiletypes = {
                    python = { 'black' },
                },
                formatters = {
                    black = {
                        command = 'black',
                        args = { '--quiet', '-' },
                        rootPatterns = { 'pyproject.toml' },
                    },
                },
            },
        },
        html = {},
        java_language_server = {},
        jsonls = {},
        lua_ls = {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        },
        nil_ls = {
            settings = {
                ['nil'] = {
                    formatting = { command = { 'nixpkgs-fmt' } },
                },
            },
        },
        pyright = {
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = 'workspace',
                        useLibraryForCodeTypes = true,
                    },
                },
            },
        },
        rust_analyzer = {},
        sqlls = {},
        terraformls = {},
        tsserver = {},
        yamlls = {
            settings = {
                yaml = {
                    keyOrdering = false,
                },
            },
        },
    }

    for server, server_config in pairs(language_servers) do
        local config = { on_attach = on_attach }

        if server_config then
            for k, v in pairs(server_config) do
                config[k] = v
            end
        end

        lspconfig[server].setup(config)
    end

    treesitter.setup {
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = { enable = true },
    }

    treesitter_context.setup()
end

return {
    init = init,
}
