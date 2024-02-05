local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
    return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

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

-- Second type of method to set the window width
-- this one uses a percentage based approach
-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--     desc = "Resize nvim-tree if nvim window got resized",
--
--     group = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true }),
--     callback = function()
--         local percentage = 20
--
--         local ratio = percentage / 100
--         local width = math.floor(vim.go.columns * ratio)
--         vim.cmd("tabdo NvimTreeResize " .. width)
--     end,
-- })


nvimtree.setup({
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
        update_root = true
    },
})
