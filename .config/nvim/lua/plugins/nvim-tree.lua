vim.g.loaded_netrwPlugin = 1
vim.g.loaded = 1

-- quick and dirty function to set the window width
local width = function()
    local winwidth = vim.fn.winwidth(0)
    if winwidth <= 100 then
        return 25
    elseif winwidth <= 200 then
        return 35
    else
        return 45
    end
end

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    after = "nvim-web-devicons",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({
            view = {
                width = width(),
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
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
        })
    end,
}
