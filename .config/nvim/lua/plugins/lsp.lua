return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        local keymap = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }

        local on_attach = function(_, bufnr) -- client
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            keymap.set(
                "n",
                "gi",
                "<cmd>Telescope lsp_implementations<CR>",
                opts
            ) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            keymap.set(
                "n",
                "gt",
                "<cmd>Telescope lsp_type_definitions<CR>",
                opts
            ) -- show lsp type definitions

            opts.desc = "See available code actions"
            keymap.set(
                { "n", "v" },
                "<leader>ca",
                vim.lsp.buf.code_action,
                opts
            ) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set(
                "n",
                "<leader>D",
                "<cmd>Telescope diagnostics bufnr=0<CR>",
                opts
            ) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<cr>", opts) -- mapping to restart lsp if necessary
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Pyright stuff
        -- Additiona info: https://microsoft.github.io/pyright/#/configuration?id=diagnostic-settings-defaults
        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- lspconfig["pyright"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = {
        --         pyright = {
        --             disableLanguageServices = false,
        --             disableOrganizeImports = false,
        --         },
        --         python = {
        --             analysis = {
        --                 typeCheckingMode = "off",
        --                 useLibraryCodeForTypes = false,
        --                 autoImportCompletions = true,
        --             },
        --         },
        --     },
        -- })

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
                "--offset-encoding=utf-16",
            },
        })

        -- configure the shellcheck server
        lspconfig["bashls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- lspconfig["denols"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        -- })

        -- configure julia server
        lspconfig["julials"].setup({
            cmd = {
                "/opt/homebrew/bin/julia",
                "--startup-file=no",
                "--history-file=no",
                "-e",
                [[
                using Pkg; 
                Pkg.instantiate();
                using LanguageServer; 
                using StaticLint; 
                using JuliaFormatter;
                import SymbolServer;
                depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
                project_path = get(ENV, "JULIA_PROJECT", "")
                if isempty(project_path)
                    project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
                end
                @info "Running language server" project_path depot_path
                server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
                server.runlinter = true
                run(server)
            ]],
            },
            capabilities = capabilities,
            settings = {
                julia = {
                    lint = {
                        run = true,
                        missingrefs = true, -- example setting to enable linting for missing references
                    },
                },
            },
            on_attach = function(client, bufnr)
                vim.diagnostic.config({
                    virtual_text = true,
                    signs = true,
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                })

                local signs = {
                    Error = " ",
                    Warn = " ",
                    Hint = " ",
                    Info = " ",
                }
                for type, icon in pairs(signs) do
                    local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(
                        hl,
                        { text = icon, texthl = hl, numhl = hl }
                    )
                end
            end,
        })

        lspconfig["rust_analyzer"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["tsserver"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
    end,
}
