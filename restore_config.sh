#!/bin/bash

# 定义变量
REPO_DIR=~/my_configs
VIMRC_FILE=~/.vimrc
BASHRC_FILE=~/.bashrc
ZSHRC_FILE=~/.zshrc
ALIASES_FILE=~/.aliases
FUNCTIONS_FILE=~/.shell/functions.sh
ZSH_SETTINGS_FILE=~/.zsh/settings.zsh
BASH_SETTINGS_FILE=~/.shell/setting.sh
ENV_VARS_FILE=~/env_vars.sh
AGNOSTER_THEME_FILE=~/.oh-my-zsh/themes/agnoster.zsh-theme

DATE=$(date +"%Y-%m-%d %H:%M:%S")
LOG_FILE=~/dotfiles_restore.log

# 记录恢复操作日志
echo "Restore started at $DATE" >> "$LOG_FILE"

# 切换到备份目录
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# 复制配置文件回正确位置
cp -f .vimrc "$VIMRC_FILE" && echo "Restored .vimrc" >> "$LOG_FILE" || echo "Failed to restore .vimrc" >> "$LOG_FILE"
cp -f .bashrc "$BASHRC_FILE" && echo "Restored .bashrc" >> "$LOG_FILE" || echo "Failed to restore .bashrc" >> "$LOG_FILE"
cp -f .zshrc "$ZSHRC_FILE" && echo "Restored .zshrc" >> "$LOG_FILE" || echo "Failed to restore .zshrc" >> "$LOG_FILE"
cp -f .aliases "$ALIASES_FILE" && echo "Restored .aliases" >> "$LOG_FILE" || echo "Failed to restore .aliases" >> "$LOG_FILE"
cp -f functions.sh "$FUNCTIONS_FILE" && echo "Restored functions.sh" >> "$LOG_FILE" || echo "Failed to restore functions.sh" >> "$LOG_FILE"
cp -f settings.zsh "$ZSH_SETTINGS_FILE" && echo "Restored settings.zsh" >> "$LOG_FILE" || echo "Failed to restore settings.zsh" >> "$LOG_FILE"
cp -f setting.sh "$BASH_SETTINGS_FILE" && echo "Restored setting.sh" >> "$LOG_FILE" || echo "Failed to restore setting.sh" >> "$LOG_FILE"
cp -f env_vars.sh "$ENV_VARS_FILE" && echo "Restored env_vars.sh" >> "$LOG_FILE" || echo "Failed to restore env_vars.sh" >> "$LOG_FILE"
cp -f agnoster.zsh-theme "$AGNOSTER_THEME_FILE" && echo "Restored agnoster.zsh-theme" >> "$LOG_FILE" || echo "Failed to restore agnoster.zsh-theme" >> "$LOG_FILE"

# 记录完成时间
DATE=$(date +"%Y-%m-%d %H:%M:%S")
echo "Restore completed at $DATE" >> "$LOG_FILE"

echo "Configuration files have been restored successfully."
