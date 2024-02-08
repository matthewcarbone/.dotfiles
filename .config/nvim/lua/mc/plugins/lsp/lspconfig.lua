-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
    return
end

-- local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
    local diagnostics = nil
    diagnostics = diagnostic.get(buf_num, { severity = severity })

    local qf_items = diagnostic.toqflist(diagnostics)
    vim.fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items })

    -- open quickfix by default
    vim.cmd [[copen]]
end

local on_attach = function(client, bufnr)
    -- Mappings.
    local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.silent = true
        opts.buffer = bufnr
        keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "go to definition" })
    map("n", "<C-]>", vim.lsp.buf.definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "variable rename" })
    map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
    map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
    map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
    -- this puts diagnostics from opened files to quickfix
    map("n", "<leader>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })
    -- this puts diagnostics from current buffer to quickfix
    map("n", "<leader>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })

    -- Set some key bindings conditional on server capabilities
    -- if client.server_capabilities.documentFormattingProvider then
    --     map("n", "<leader>f", vim.lsp.buf.format, { desc = "format code" })
    -- end

    api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local float_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always", -- show source in diagnostic popup window
                prefix = " ",
            }

            if not vim.b.diagnostics_pos then
                vim.b.diagnostics_pos = { nil, nil }
            end

            local cursor_pos = api.nvim_win_get_cursor(0)
            if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
                and #diagnostic.get() > 0
            then
                diagnostic.open_float(nil, float_opts)
            end

            vim.b.diagnostics_pos = cursor_pos
        end,
    })

    -- The blow command will highlight the current variable and its usages in the buffer.
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
      ]])

        local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_create_autocmd("CursorHold", {
            group = gid,
            buffer = bufnr,
            callback = function()
                lsp.buf.document_highlight()
            end
        })

        api.nvim_create_autocmd("CursorMoved", {
            group = gid,
            buffer = bufnr,
            callback = function()
                lsp.buf.clear_references()
            end
        })
    end

    if vim.g.logging_level == "debug" then
        local msg = string.format("Language server %s started!", client.name)
        vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
            require('swenv.api').auto_venv()
        end
    })
end


-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
    },
})

-- configure python server
lspconfig["pyright"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
        },
        python = {
            analysis = {
                typeCheckingMode = "off",
                useLibraryCodeForTypes = false,
                autoImportCompletions = true,
            }
        }
    },
})

-- configure cmake server
lspconfig["cmake"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure c++ server
lspconfig["clangd"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--offset-encoding=utf-16"
    }
})

-- try to configure flake8???
-- lspconfig["flake8"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- configure the shellcheck server
lspconfig["bashls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})

vim.diagnostic.config({
    virtual_text = false, -- Turn off inline diagnostics
})

-- Use this if you want it to automatically show all diagnostics on the
-- current line in a floating window. Personally, I find this a bit
-- distracting and prefer to manually trigger it (see below). The
-- CursorHold event happens when after `updatetime` milliseconds. The
-- default is 4000 which is much too long
--vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
--vim.o.updatetime = 300

-- Show all diagnostics on current line in floating window
-- vim.api.nvim_set_keymap(
--   'n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>',
--   { noremap = true, silent = true }
-- )

local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', {})

-- Go to next diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap('n', '<leader>n', ':lua vim.diagnostic.goto_next()<CR>', opts)

-- Go to prev diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap('n', '<leader>p', ':lua vim.diagnostic.goto_prev()<CR>', opts)
