# ----------------------------------------------------------------------------
# SOURCE API KEYS
# ----------------------------------------------------------------------------
# Special hidden files for environment variable API keys
# obviously we don't commit this to vcs
source ~/.api_keys

# ----------------------------------------------------------------------------
# POWERLEVEL10K CONFIG
# ----------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"

# ----------------------------------------------------------------------------
# SETUP FOR HOMEBREW
# ----------------------------------------------------------------------------
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH   
export COPYFILE_DISABLE=true

# Handle deactivating conda environments before using homebrew
# See here: https://stackoverflow.com/questions/42859781/best-practices-with-anaconda-and-brew
brew() {
    local -a conda_envs
    while [ "$CONDA_SHLVL" -gt 0  ]; do
        echo "Deactivating conda environment(s)..."
        conda_envs=("$CONDA_DEFAULT_ENV" $conda_envs)
        conda deactivate
    done
    command brew $@
    local brew_status=$?
    for env in $conda_envs; do
        conda activate "$env"
    done
    unset env
    return "$brew_status"
}

# ----------------------------------------------------------------------------
# CHANGE DEFAULT EDITOR TO NEOVIM
# ----------------------------------------------------------------------------
export EDITOR=/opt/homebrew/bin/nvim
alias vi="$EDITOR"


# ----------------------------------------------------------------------------
# OH-MY-ZSH CONFIGURATION AND SOURCING
# ----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions direnv)
source $ZSH/oh-my-zsh.sh

# ----------------------------------------------------------------------------
# CONDA INIT
# ----------------------------------------------------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mc/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mc/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/mc/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mc/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ----------------------------------------------------------------------------
# FUZZY FINDER DEFAULT FLAGS
# ----------------------------------------------------------------------------
export FZF_DEFAULT_OPS="--tmux --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"

# ----------------------------------------------------------------------------
# ZOXIDE INIT
# ----------------------------------------------------------------------------
eval "$(zoxide init zsh)"

# ----------------------------------------------------------------------------
# QUALITY OF LIFE UTILITIES
# ----------------------------------------------------------------------------
alias df='df -h'  # Disk storage
alias ls='eza --icons'
alias ll='eza -l -g --icons'
alias grep='grep --color=auto'
alias tsp='ts'

# ----------------------------------------------------------------------------
# FINAL SOURCE P10K
# ----------------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/zsh/config/.p10k.zsh.
[[ ! -f ~/zsh/config/.p10k.zsh ]] || source ~/zsh/config/.p10k.zsh

# ----------------------------------------------------------------------------
# FINAL SOURCE ATUIN (https://atuin.sh/)
# ----------------------------------------------------------------------------
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
