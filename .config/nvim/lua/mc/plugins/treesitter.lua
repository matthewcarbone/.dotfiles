local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    highlight = {
        enable = true
    },
    indent = { enable = true },
    autotag = { enable = true },
    ensure_installed = {
        "cpp",
        "cmake",
        "python",
        "rust",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "git_config",
        "gitattributes",
        "git_rebase",
        "gitcommit"
    },
    auto_install = true,
})
