#!/bin/bash

# 定义变量
REPO_DIR=~/my-configs
VIMRC_FILE=~/.vimrc
BASHRC_FILE=~/.bashrc
ZSHRC_FILE=~/.zshrc
ALIASES_FILE=~/.aliases
FUNCTIONS_FILE=~/.shell/functions.sh
ZSH_SETTINGS_FILE=~/.zsh/settings.zsh
BASH_SETTINGS_FILE=~/.shell/setting.sh
ENV_VARS_FILE=~/.env_vars
TMUX_FILE=~/.tmux.conf
CURLRC_FILE=~/.curlrc
GDBINIT_FILE=~/.gdbinit
WGETRC_FILE=~/.wgetrc
INPUTRC_FILE=~/.inputrc
GITCONFIG_FILE=~/.gitconfig
GITIGNORE_FILE=~/.gitignore
EXPORTS_FILE=~/.exports
AGNOSTER_THEME_FILE=~/.oh-my-zsh/themes/agnoster.zsh-theme

DATE=$(date +"%Y-%m-%d %H:%M:%S")


# 记录恢复操作日志
echo "Restore started at $DATE"

# 切换到备份目录
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# 检查并创建 ~/.zsh 目录
if [ ! -d "$HOME/.zsh" ]; then
    mkdir -p ~/.zsh && echo "mkdir .zsh" || echo "Failed to mkdir .zsh"
else
    echo "~/.zsh already exists"
fi

# 检查并创建 ~/.shell 目录
if [ ! -d "$HOME/.shell" ]; then
    mkdir -p ~/.shell && echo "mkdir .shell" || echo "Failed to mkdir .shell"
else
    echo "~/.shell already exists"
fi


# 复制配置文件回正确位置
cp -f .vimrc "$VIMRC_FILE" && echo "Restored .vimrc"|| echo "Failed to restore .vimrc"
cp -f .bashrc "$BASHRC_FILE" && echo "Restored .bashrc"|| echo "Failed to restore .bashrc"
cp -f .zshrc "$ZSHRC_FILE" && echo "Restored .zshrc" || echo "Failed to restore .zshrc"
cp -f .aliases "$ALIASES_FILE" && echo "Restored .aliases" || echo "Failed to restore .aliases"
cp -f functions.sh "$FUNCTIONS_FILE" && echo "Restored functions.sh" || echo "Failed to restore functions.sh"
cp -f settings.zsh "$ZSH_SETTINGS_FILE" && echo "Restored settings.zsh" || echo "Failed to restore settings.zsh"
cp -f setting.sh "$BASH_SETTINGS_FILE" && echo "Restored setting.sh" || echo "Failed to restore setting.sh"
cp -f .env_vars "$ENV_VARS_FILE" && echo "Restored env_vars.sh" || echo "Failed to restore .env_vars"
cp -f .tmux.conf "$TMUX_FILE" && echo "Restored env_vars.sh" || echo "Failed to restore .tmux.conf"
# cp -f agnoster.zsh-theme "$AGNOSTER_THEME_FILE" && echo "Restored agnoster.zsh-theme" || echo "Failed to restore agnoster.zsh-theme"
cp -f .curlrc "$CURLRC_FILE" && echo "Restored .curlrc" || echo "Failed to restore .curlrc"
cp -f .gdbinit "$GDBINIT_FILE" && echo "Restored .gdbinit" || echo "Failed to restore .gdbinit"
cp -f .wgetrc "$WGETRC_FILE" && echo "Restored .wgetrc" || echo "Failed to restore .wgetrc"
cp -f .inputrc "$INPUTRC_FILE" && echo "Restored .inputrc" || echo "Failed to restore .inputrc"
cp -f .gitconfig "$GITCONFIG_FILE" && echo "Restored .gitconfig" || echo "Failed to restore .gitconfig"
cp -f .gitignore "$GITIGNORE_FILE" && echo "Restored .gitignore" || echo "Failed to restore .gitignore"
cp -f .exports "$EXPORTS_FILE" && echo "Restored .exports" || echo "Failed to restore .exports"

# 记录完成时间
DATE=$(date +"%Y-%m-%d %H:%M:%S")
echo "Restore completed at $DATE"

echo "Configuration files have been restored successfully."
