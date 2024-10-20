[[ -f $HOME/.aliases ]] && source $HOME/.aliases

[[ -f $HOME/.shell/functions.sh ]] && source $HOME/.shell/functions.sh

[[ -f $HOME/.shell/setting.sh ]] && source $HOME/.shell/setting.sh

[[ -f $HOME/.env_vars]] && source $HOME/.env_vars
. "$HOME/.cargo/env"

eval "$(fnm env --multi 2>& /dev/null)"
