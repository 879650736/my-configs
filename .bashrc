[[ -f $HOME/.aliases ]] && source $HOME/.aliases

[[ -f $HOME/.shell/functions.sh ]] && source $HOME/.shell/functions.sh

[[ -f $HOME/.shell/setting.sh ]] && source $HOME/.shell/setting.sh

[[ -f $HOME/.env_vars ]] && source $HOME/.env_vars

export PATH=/home/ssy/x-tools/arm-unknown-linux-gnueabi/bin:$PATH
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
export LIBVIRT_DEFAULT_URI='qemu:///system'
. "$HOME/.cargo/env"
