# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=/opt/homebrew/bin:$PATH   
    # Disable the nonsense of MacOS saving hidden files for everything when
    # using tar
    export COPYFILE_DISABLE=true
fi

# Specific hdspin convenience
# TODO: custom setup
export PATH="$HOME"/GitHub/hdspin/build:$PATH

# Set the default editor
# export EDITOR=/usr/bin/vi
if [[ "$OSTYPE" == "darwin"* ]]; then
    export EDITOR=/opt/homebrew/bin/nvim
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export EDITOR=/usr/bin/nvim
fi

# CREM stores a bunch of molecular fragments which we can use for
# molecular design. This points to the path containing fragments of
# r \in {1, 2, 3} for C, N, O, and F fragments
# TODO: custom setup
export CREM_DB_PATH="$HOME"/Data/crem_data/replacements02_sc2.db

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions direnv)

source $ZSH/oh-my-zsh.sh

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

if [[ "$OSTYPE" == "darwin"* ]]; then
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
fi

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select


if [[ "$OSTYPE" == "darwin"* ]]; then
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-3.1.2
    export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"
    alias vi='/opt/homebrew/bin/nvim'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias vi='/usr/bin/nvim'
fi

alias df='df -h'
alias ls='eza --icons'
alias ll='eza -l -g --icons'
alias grep='grep --color=auto'
alias opens='open -a Sublime\ Text'

# TODO: custom

# Connection to the Institutional Cluster at Brookhaven National Lab
# alias ic='ssh -A -tt bnl_login ssh icsubmit01.sdcc.bnl.gov'
alias ic='ssh bnl_compute'

# Connection to my workstation at BNL CSI (requires intranet connection)
alias ws='ssh bnl_workstation'

# Reichman Rocks cluster at Columbia University
alias rr='ssh -p 22222 -YC mcarbone@dyn.gw.reichman.zgib.net'

# Reichman Rocks cluster via SonicWall VPN
# alias rrvpn='ssh -tXYC mcarbone@192.168.100.70'
alias rrvpn='ssh -tXY rrvpn_via_vickyp'

# NERSC Cori
alias cori='ssh mrc2215@cori.nersc.gov'

# NERSC Cori with pre-generated 24h login key
alias cori24='ssh -i ~/.ssh/nersc mrc2215@cori.nersc.gov'

# Points to the columbia Habanero cluster
alias habanero='ssh mrc2215@habanero.rcs.columbia.edu'

# Activate CONDA environment with the name of the current directory
alias a='conda activate "${PWD##*/}"' 

# Deactivate CONDA encironment (return to base)
alias da='conda deactivate'

# Activate/deactivate pip virtual environment
alias apip='source .env/bin/activate'

# Mount/unmount the institutional cluster home directory
alias mount_ic_home='sshfs bnl_compute:/sdcc/u/mcarbone ~/Mount/ic'
alias unmount_ic_home='umount ~/Mount/ic'

# Task spooler
# for some reason the alias is now ts
alias tsp='ts'

# Special hidden files for environment variable API keys
# obviously we don't commit this to vcs
source ~/.api_keys



uvsh() {
    local venv_name=${1:-'.venv'}
    venv_name=${venv_name//\//} # remove trailing slashes (Linux)
    venv_name=${venv_name//\\/} # remove trailing slashes (Windows)

    local venv_bin=
    if [[ -d ${WINDIR} ]]; then
        venv_bin='Scripts/activate'
    else
        venv_bin='bin/activate'
    fi

    local activator="${venv_name}/${venv_bin}"
    echo "[INFO] Activate Python venv: ${venv_name} (via ${activator})"

    if [[ ! -f ${activator} ]]; then
        echo "[ERROR] Python venv not found: ${venv_name}"
        return
    fi

    # shellcheck disable=SC1090
    . "${activator}"
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi


# To customize prompt, run `p10k configure` or edit ~/zsh/config/.p10k.zsh.
[[ ! -f ~/zsh/config/.p10k.zsh ]] || source ~/zsh/config/.p10k.zsh
