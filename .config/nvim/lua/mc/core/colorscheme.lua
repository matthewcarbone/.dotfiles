local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
    print("Colorscheme not found!")
    return
end
print("Colorsheme tokyonight")

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     style = "day",
--     transparent = true,
--     styles = {
--       sidebars = "transparent",
--       floats = "transparent",
--     },
--   },
--   config = function(_, opts)
--     local tokyonight = require "tokyonight"
--     tokyonight.setup(opts)
--     tokyonight.load()
--   end,
-- }

