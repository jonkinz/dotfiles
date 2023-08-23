#!/bin/zsh

# zmodload zsh/zprof
# if [ -z "$TMUX" ]
# then
#     tmux attach -t TMUX || tmux new -s TMUX
# fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$HOME/bin:/$HOME/.local/bin:$PATH:/$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$HOME/.cargo/bin:$HOME/.local/share/zap:$HOME/.local/bin/java/jdk-20.0.1/bin:$HOME/.local/bin/gradle/gradle-8.1.1/bin
# no beeping
unsetopt BEEP
zle_highlight=('paste:none')

# FZF config
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_PREVIEW='--preview "bat --style=numbers --color=always --line-range :500 {}"'

export EDITOR="nvim"
export VISUAL="nvim" 
export JAVA_HOME=$HOME/.local/bin/java/jdk-20.0.1
# Attempt to use linux GUI apps in WSL2
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0 # in WSL 2
export LIBGL_ALWAYS_INDIRECT=1
# export PULSE_SERVER=tcp:$(grep nameserver /etc/resolv.conf | awk '{print $2}');
export PULSE_COOKIE=/mnt/c/Users/$WINDOWS_USERNAME/.pulse-cookie

export HOST_IP="$(ip route |awk '/^default/{print $3}')"
export PULSE_SERVER="tcp:$HOST_IP"

#!/bin/zsh
# PULSE_FILE="/mnt/c/pulse/etc/pulse/default.pa"
# PULSE_IP=$(ip a | grep "inet " | grep "eth0" | awk '{print $2}')
# REPLACE="load-module module-native-protocol-tcp auth-ip-acl=$PULSE_IP auth-anonymous=1"
#
# if test -f "$PULSE_FILE"; then
#     sed -i "61s|.*|$REPLACE|" $PULSE_FILE
# fi

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
# plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "esc/conda-zsh-completion"

# Load and initialise completion system
autoload -Uz compinit
compinit

source "$HOME/.dotfiles/zsh/.my_aliases"
source "$HOME/.dotfiles/zsh/.my_functions"
# plug "$HOME/.dotfiles/zsh/.my_aliases"
# plug "$HOME/.dotfiles/zsh/.my_functions"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
# zprof
#
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | /mnt/c/windows/system32/clip.exe
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# nvim distro switcher courtesy of :
# https://github.com/elijahmanor/dotfiles/blob/master/zsh/.zshrc
# git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/AstroNvim
# git clone git@github.com:nvim-lua/kickstart.nvim.git ~/.config/kickstart
# git clone https://github.com/NvChad/NvChad ~/.config/NvChad --depth 1
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-chad="NVIM_APPNAME=DuskNvim nvim"
function nvims() {
  items=("default" "kickstart" "NvChad" "AstroNvim" "DuskNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
# bindkey -s ^a "nvims\n"
#
eval "$(zoxide init zsh)"
