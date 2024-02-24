-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- for conciseness
local keymap = vim.keymap

-- general
-- mode, keybind, action
-- This is not something I actually want, since it replaces the j+k to
-- escape, which I think would be confusing to me...
-- keymap.set("i", "jk", "<ESC>")

-- This will clear the search bar if you pres nh
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Window splits
keymap.set("n", "<leader>sv", "<C-w>v") -- splits vert
keymap.set("n", "<leader>sh", "<C-w>s") -- splits horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- makes window splits of equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current splits

-- Tabs!
keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- Plugin keymaps

-- vim maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- Custom delete line without making newline
-- instead of cc<Esc>, we just use dD
keymap.set("n", "dD", "cc<Esc>")

-- Undotree remap
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Adjust window width
keymap.set("n", "<leader>we", ":NvimTreeResize ")

-- Autoformatting with lsp or black depending on which filetype we're in
vim.keymap.set("n", "<leader>mf", function()
  if vim.bo.filetype == "python" then
    vim.cmd("!black %")
    vim.cmd("!isort %")
  else
    vim.lsp.buf.format()
  end
end)

-- Telescope projects
vim.keymap.set("n", "<leader>j", ":Telescope projects<CR>")

--
-- vim.keymap.set("n", "<leader>we", function()
--     local user_input = vim.fn.input("Enter input: ")
--     local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { "_{" .. user_input .. "}" })
-- end)
-- Find and replace all instances of a text with something else
-- this doesn't quite work
-- keymap.set("n", "<leader>s", "[[:%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>]]")
