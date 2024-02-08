local setup, swenv = pcall(require, "swenv")
if not setup then
    return
end

-- Automatically set the virtual environment from .venv file


swenv.setup({
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    -- get_venvs = function(venvs_path)
    --     return swenv.api.auto_venv()
    -- end,
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand('/Users/mc/miniforge3/envs'),
    -- Something to do after setting an environment, for example call vim.cmd.LspRestart
    post_set_venv = function(_)
        vim.cmd.LspRestart()
    end,
})



-- local settings = swenv.config.settings
-- print(swenv)
-- print(settings(settings.get_venvs(settings.venvs_path)))
