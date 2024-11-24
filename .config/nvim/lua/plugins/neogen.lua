local opts = { noremap = true, silent = true }
-- local function setup_neogen()
-- end

return {
    "danymat/neogen",
    lazy = false,
    version = "*",
    config = function()
        require("neogen").setup({
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = "numpydoc",
                    },
                },
            },
        })
    end,
    keys = {
        {
            "<Leader>nf",
            ":lua require('neogen').generate()<CR>",
            opts,
        },
    },
}
