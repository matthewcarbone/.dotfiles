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

    -- auto-closing
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")

    if packer_bootstrap then
        require("packer").sync()
    end
end)
