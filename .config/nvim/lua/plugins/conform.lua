return {
  "stevearc/conform.nvim",
  lazy = false,
  tag = "v5.3.0",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      python = { "isort", "black" },
      sh = { "shfmt" },
    },
  },
}
