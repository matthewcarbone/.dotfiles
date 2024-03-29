local opt = vim.opt -- for conciseness

-- line numbers
-- Note that double-dashes are for comments
opt.relativenumber = true
opt.number = true

-- minimum number of lines to display
opt.scrolloff = 8

-- tabbing and indentation
opt.tabstop = 4  -- use 4 spaces for tabs
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
-- Forces nvim to use the system clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- for cursor hold events
opt.updatetime = 500

-- amount of time before timing out when attempting a command
opt.timeoutlen = 500

-- color ruler!
opt.colorcolumn = "80"
vim.g.virtcolumn_char = '▕' -- char to display the line
vim.g.virtcolumn_priority = 10 -- priority of extmark

-- signify
vim.g.signify_sign_overwrite = 0

-- DOGE
vim.g.doge_doc_standard_python = "numpy"

