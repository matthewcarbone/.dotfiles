return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<CR>"] = actions.select_default,
                        ["<C-n>"] = false,
                        ["<C-p>"] = false,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--iglob", "!.git" },
                    hidden = true,
                },
            },
        })
    end,
}
