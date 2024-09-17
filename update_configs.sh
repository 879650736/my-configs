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
COMMIT_MESSAGE="Update configuration files at $DATE"

# 切换到目标目录
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# 复制配置文件
cp "$VIMRC_FILE" . || { echo "Failed to copy directory to .vimrc"; }
cp "$BASHRC_FILE" . || { echo "Failed to copy directory to .bashrc"; }
cp "$ZSHRC_FILE" . || { echo "Failed to copy directory to .zshrc"; }
cp "$ALIASES_FILE" . || { echo "Failed to copy directory to .aliases"; }
cp "$FUNCTIONS_FILE" . || { echo "Failed to copy directory to functions.sh"; }
cp "$ZSH_SETTINGS_FILE" . || { echo "Failed to copy directory to settings.zsh"; }
cp "$BASH_SETTINGS_FILE" . || { echo "Failed to copy directory to setting.sh"; }
cp "$ENV_VARS_FILE" . || { echo "Failed to copy directory to  env_vars.sh"; }
cp "$AGNOSTER_THEME_FILE" . || { echo "Failed to copy directory to agnoster.zsh-theme"; }

# 添加更改到 Git
git add . || { echo "Failed to add changes to git"; exit 1; }

# 提交更改
git commit -m "$COMMIT_MESSAGE" || { echo "Failed to commit changes"; exit 1; }

# 推送更改到远程仓库
git push -u origin master || { echo "Failed to push changes to remote repository"; exit 1; }

echo "Update completed successfully."

