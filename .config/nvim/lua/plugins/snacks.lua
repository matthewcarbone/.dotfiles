-- lazy.nvim
return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            hidden = true,
        },
    },
}
