local setup, wrapping = pcall(require, "wrapping")

if not setup then
    return
end

local opts = {
    auto_set_mode_filetype_allowlist = {
        "asciidoc",
        "gitcommit",
        "latex",
        "mail",
        "markdown",
        "rst",
        "tex",
        "text",
    },
    auto_set_mode_heuristically = false,
}

wrapping.setup(opts)
wrapping.set_mode_heuristically()
