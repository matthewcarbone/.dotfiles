local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
    return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
    view = {
        width = 35,
        relativenumber = true,
    },
    -- change folder arrow icons
    renderer = {
        indent_markers = {
            enable = true,
        },
        icons = {
            glyphs = {
                folder = {
                    arrow_closed = "", -- arrow when folder is closed
                    arrow_open = "", -- arrow when folder is open
                },
            },
        },
    },
    git = {
        ignore = false,
    },
    filters = {
        custom = { ".DS_Store" },
    },
})
