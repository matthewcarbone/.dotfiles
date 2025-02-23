-- Controls the dropdown autocompletes
return {
    "saghen/blink.cmp",
    opts = {
        sources = {
            default = { "lazydev" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100, -- show at a higher priority than lsp
                },
            },
        },
        keymap = {
            preset = "enter",
            ["<C-d>"] = {
                "show",
                "show_documentation",
                "hide_documentation",
            },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
        },
    },
}
