# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

###############################################################################################

# Proxy
export http_proxy="http://127.0.0.1:7897"
export https_proxy="http://127.0.0.1:7897"

# Golang
export GOPATH=$HOME/go
export PATH="$HOME/go/bin:$PATH"

# XDG_CONFIG_HOME default to ~/.config, but for some applications
# (e.g. lazygit) we should explictly configure it.
export XDG_CONFIG_HOME="$HOME/.config" 

# use 'bat' as man pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Custom alias
alias ll='ls -latr'
alias la='ls -a'

###############################################################################################

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
