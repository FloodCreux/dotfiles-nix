[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
path+=("$HOME/.cargo/bin")
export PATH
export SECOND_BRAIN="$HOME/personal/second-brain"
export CC=clang
eval "$(zoxide init --cmd cd zsh)"
