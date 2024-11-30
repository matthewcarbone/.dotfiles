return {
    "stevearc/conform.nvim",
    lazy = false,
    tag = "v8.2.0",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            fish = { "fish_indent" },
            python = function(bufnr)
                if
                    require("conform").get_formatter_info("ruff_format", bufnr).available
                then
                    return { "isort", "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
            sh = { "shfmt" },
            rust = { "rustfmt", lsp_format = "fallback" },
            typescript = { "deno_fmt" },
        },
    },
}
