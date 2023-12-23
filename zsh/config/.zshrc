# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH="$HOME"/GitHub/hdspin/build:$PATH
export PATH="$HOME"/.emacs.d/bin:$PATH
export PYTHONPATH=$PYTHONPATH:/Users/mc/Include

# Set the default editor
# export EDITOR=/usr/bin/vi
export EDITOR=/opt/homebrew/bin/nvim

# CREM stores a bunch of molecular fragments which we can use for
# molecular design. This points to the path containing fragments of
# r \in {1, 2, 3} for C, N, O, and F fragments
export CREM_DB_PATH="$HOME"/Data/crem_data/replacements02_sc2.db

# Disable the nonsense of MacOS saving hidden files for everything when
# using tar
export COPYFILE_DISABLE=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
#ZSH_THEME="bureau2"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Basic auto/tab complete:
# autoload -U compinit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)		# Include hidden files.

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"

# Source other stuff
# Here we have aliases --------
# Alias for vim
alias vi='/opt/homebrew/bin/nvim'

# General QOL aliases
alias cp='cp -i' 
alias rm='rm -i'
alias mv='mv -i'

alias df='df -h'
alias ls='exa'
alias grep='grep --color=auto'

# Major quality of life delete all the annoying .DS_Store objects
# that MacOS tends to just leave lying around everywhere
alias deleteDS_Store="find . -name .DS_Store -delete"

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

# DOOM emacs
alias demacs='emacs-29.1 -nw'
alias emax='
export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1
emacs
'

# Task spooler
# for some reason the alias is now ts
alias tsp='ts'

# Special hidden files for environment variable API keys
# obviously we don't commit this to vcs
source ~/.api_keys

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
