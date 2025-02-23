return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    buffers = {
        right = {
            enabled = false,
        },
    },
    config = function()
        vim.api.nvim_create_user_command("Nnp", "NoNeckPain", {})
    end,
}
