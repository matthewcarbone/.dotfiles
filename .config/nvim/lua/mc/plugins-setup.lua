-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed


-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim")  -- packer can manage itself

    -- lua functions that many other plugins will use
    use ("nvim-lua/plenary.nvim")

    -- Preferred colorscheme
    use("bluz71/vim-nightfly-guicolors")
    use("folke/tokyonight.nvim")

    -- tmux and split window nav
    use("christoomey/vim-tmux-navigator")

    -- maximizes and restores current window
    use("szw/vim-maximizer")

    -- essentials
    use("tpope/vim-surround")
    use("vim-scripts/ReplaceWithRegister")

    -- file explorer
    use ("nvim-tree/nvim-tree.lua")

    -- commenting with gc
    use("numToStr/Comment.nvim")

    -- icons
    use("kyazdani42/nvim-web-devicons")

    -- status bar!!!!!
    use("nvim-lualine/lualine.nvim")

    -- telescoping finding (fuzzy!)
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

    -- autocompletion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")

    -- snippets
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    -- managing & installing lsp servers, linters & formatters
    use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
    use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

    -- configuring lsp servers
    use("neovim/nvim-lspconfig") -- easily configure language servers 
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      requires = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    }) -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- formatting and liting
    use("jose-elias-alvarez/null-ls.nvim")
    use("jayp0521/mason-null-ls.nvim")

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    -- flake8 support for python
    -- use("nvie/vim-flake8")

    -- auto-closing
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")

    -- display conda environment in nvim
    use("AckslD/swenv.nvim")

    -- fun dashboard
    use {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
            theme = 'doom',
            config = {
              header = {
"                                                    ",
"                                                    ",
"                                                    ",
"                                                    ",
"                                                    ",
"                                                    ",
" ███▄    █  ▓█████ ▒█████   ██▒   █▓  ██▓ ███▄ ▄███▓",
" ██ ▀█   █  ▓█   ▀▒██▒  ██▒▓██░   █▒▒▓██▒▓██▒▀█▀ ██▒",
"▓██  ▀█ ██▒ ▒███  ▒██░  ██▒ ▓██  █▒░▒▒██▒▓██    ▓██░",
"▓██▒  ▐▌██▒ ▒▓█  ▄▒██   ██░  ▒██ █░░░░██░▒██    ▒██ ",
"▒██░   ▓██░▒░▒████░ ████▓▒░   ▒▀█░  ░░██░▒██▒   ░██▒",
"░ ▒░   ▒ ▒ ░░░ ▒░ ░ ▒░▒░▒░    ░ ▐░   ░▓  ░ ▒░   ░  ░",
"░ ░░   ░ ▒░░ ░ ░    ░ ▒ ▒░    ░ ░░  ░ ▒ ░░  ░      ░",
"   ░   ░ ░     ░  ░ ░ ░ ▒        ░  ░ ▒ ░░      ░   ",
"         ░ ░   ░      ░ ░        ░    ░         ░   ",
"                                                    ",
"                                                    ",
"                                                    ",
"                                                    ",
"                                                    ",
"                                                    ",
                    }, --your header
              center = {
                {
                  icon = ' ',
                  icon_hl = 'Title',
                  desc = 'Find File           ',
                  desc_hl = 'String',
                  key = 'b',
                  keymap = 'SPC f f',
                  key_hl = 'Number',
                  key_format = ' %s', -- remove default surrounding `[]`
                  action = 'lua print(2)'
                },
                {
                  icon = ' ',
                  desc = 'Find Dotfiles',
                  key = 'f',
                  keymap = 'SPC f d',
                  key_format = ' %s', -- remove default surrounding `[]`
                  action = 'lua print(3)'
                },
              },
              footer = {}  --your footer
            }
          })
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- Automatic wrapping in certain situations
    -- use :set wrap to enable
    use({
        "andrewferrier/wrapping.nvim",
        -- config = function()
        --     require("wrapping").setup()
        -- end,
    })

    -- For a nice vertical barrier at 80 characters
    -- used as a ruler
    use({
        "xiyaowong/virtcolumn.nvim",
        commit = "4d385b4aa42aa3af6fa2cb8527462fa4badbd163",
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
