local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
    return
end
