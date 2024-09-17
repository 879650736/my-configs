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
ENV_VARS_FILE=~/.env_vars.sh
DATE=$(date +"%Y-%m-%d %H:%M:%S")
COMMIT_MESSAGE="Update configuration files at $DATE"

# 切换到目标目录
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# 复制配置文件
cp "$VIMRC_FILE" .
cp "$BASHRC_FILE" .
cp "$ZSHRC_FILE" .
cp "$ALIASES_FILE" .
cp "$FUNCTIONS_FILE" .
cp "$ZSH_SETTINGS_FILE" .
cp "$BASH_SETTINGS_FILE" .
cp "$ENV_VARS_FILE" .

# 添加更改到 Git
git add . || { echo "Failed to add changes to git"; exit 1; }

# 提交更改
git commit -m "$COMMIT_MESSAGE" || { echo "Failed to commit changes"; exit 1; }

# 推送更改到远程仓库
git push -u origin master || { echo "Failed to push changes to remote repository"; exit 1; }

echo "Update completed successfully."

