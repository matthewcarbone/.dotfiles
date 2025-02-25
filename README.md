# Matthew Carbone's `.dotfiles`

- Managed by `stow` (`brew install stow`). See [here](https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/) for a good introduction and links to the documentation.
- Quick note: make sure that the directory structure in `~/.dotfiles` matches exactly the paths that you want symlinks to be created to starting from your home directory.
- Inspired by the awesome setup by [tcmmichaelb139](https://github.com/tcmmichaelb139/.dotfiles).

# Setup

First we require homebrew, which should be installed first.

```bash
brew install stow
brew install neovim
brew install exa
brew install --cask alacritty
```

# List of dotfiles

- [ObsidianMC](/ObsidianMC/README.md) My personal Obsidian vault css files and other parameters.
- [scripts](/scripts/README.md) Misc. scripts that I use for a variety of reasons.


# Some notes
- Fonts are a pain in the neck. You want "JetbrainsMono Nerd Font" or something along those lines: https://www.nerdfonts.com/font-downloads.
- [Tokyo Night Color Palette](https://lospec.com/palette-list/tokyo-night)

