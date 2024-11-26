return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                    },
                },
            },
        })
    end,
}
