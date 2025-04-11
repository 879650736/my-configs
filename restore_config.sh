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

#旧文件进行备份
if [ -f "$VIMRC_FILE" ]; then
    mv "$VIMRC_FILE" "$VIMRC_FILE.bak" && echo "Backup .vimrc to .vimrc.bak" || echo "Failed to backup .vimrc"
fi
if [ -f "$BASHRC_FILE" ]; then
    mv "$BASHRC_FILE" "$BASHRC_FILE.bak" && echo "Backup .bashrc to .bashrc.bak" || echo "Failed to backup .bashrc"
fi
if [ -f "$ZSHRC_FILE" ]; then
    mv "$ZSHRC_FILE" "$ZSHRC_FILE.bak" && echo "Backup .zshrc to .zshrc.bak" || echo "Failed to backup .zshrc"
fi
if [ -f "$ALIASES_FILE" ]; then
    mv "$ALIASES_FILE" "$ALIASES_FILE.bak" && echo "Backup .aliases to .aliases.bak" || echo "Failed to backup .aliases"
fi
if [ -f "$FUNCTIONS_FILE" ]; then
    mv "$FUNCTIONS_FILE" "$FUNCTIONS_FILE.bak" && echo "Backup functions.sh to functions.sh.bak" || echo "Failed to backup functions.sh"
fi
if [ -f "$ZSH_SETTINGS_FILE" ]; then
    mv "$ZSH_SETTINGS_FILE" "$ZSH_SETTINGS_FILE.bak" && echo "Backup settings.zsh to settings.zsh.bak" || echo "Failed to backup settings.zsh"
fi
if [ -f "$BASH_SETTINGS_FILE" ]; then
    mv "$BASH_SETTINGS_FILE" "$BASH_SETTINGS_FILE.bak" && echo "Backup setting.sh to setting.sh.bak" || echo "Failed to backup setting.sh"
fi
if [ -f "$ENV_VARS_FILE" ]; then
    mv "$ENV_VARS_FILE" "$ENV_VARS_FILE.bak" && echo "Backup env_vars.sh to env_vars.sh.bak" || echo "Failed to backup env_vars.sh"
fi
if [ -f "$TMUX_FILE" ]; then
    mv "$TMUX_FILE" "$TMUX_FILE.bak" && echo "Backup .tmux.conf to .tmux.conf.bak" || echo "Failed to backup .tmux.conf"
fi
if [ -f "$CURLRC_FILE" ]; then
    mv "$CURLRC_FILE" "$CURLRC_FILE.bak" && echo "Backup .curlrc to .curlrc.bak" || echo "Failed to backup .curlrc"
fi
if [ -f "$GDBINIT_FILE" ]; then
    mv "$GDBINIT_FILE" "$GDBINIT_FILE.bak" && echo "Backup .gdbinit to .gdbinit.bak" || echo "Failed to backup .gdbinit"
fi
if [ -f "$WGETRC_FILE" ]; then
    mv "$WGETRC_FILE" "$WGETRC_FILE.bak" && echo "Backup .wgetrc to .wgetrc.bak" || echo "Failed to backup .wgetrc"
fi
if [ -f "$INPUTRC_FILE" ]; then
    mv "$INPUTRC_FILE" "$INPUTRC_FILE.bak" && echo "Backup .inputrc to .inputrc.bak" || echo "Failed to backup .inputrc"
fi
if [ -f "$GITCONFIG_FILE" ]; then
    mv "$GITCONFIG_FILE" "$GITCONFIG_FILE.bak" && echo "Backup .gitconfig to .gitconfig.bak" || echo "Failed to backup .gitconfig"
fi
if [ -f "$GITIGNORE_FILE" ]; then
    mv "$GITIGNORE_FILE" "$GITIGNORE_FILE.bak" && echo "Backup .gitignore to .gitignore.bak" || echo "Failed to backup .gitignore"
fi
if [ -f "$EXPORTS_FILE" ]; then
    mv "$EXPORTS_FILE" "$EXPORTS_FILE.bak" && echo "Backup .exports to .exports.bak" || echo "Failed to backup .exports"
fi
if [ -f "$AGNOSTER_THEME_FILE" ]; then
    mv "$AGNOSTER_THEME_FILE" "$AGNOSTER_THEME_FILE.bak" && echo "Backup agnoster.zsh-theme to agnoster.zsh-theme.bak" || echo "Failed to backup agnoster.zsh-theme"
fi

# 复制配置文件回正确位置
cp -f .vimrc "$VIMRC_FILE" && echo "Restored .vimrc"|| echo "Failed to restore .vimrc"
cp -f .bashrc "$BASHRC_FILE" && echo "Restored .bashrc"|| echo "Failed to restore .bashrc"
cp -f .zshrc "$ZSHRC_FILE" && echo "Restored .zshrc" || echo "Failed to restore .zshrc"
cp -f .aliases "$ALIASES_FILE" && echo "Restored .aliases" || echo "Failed to restore .aliases"
cp -f functions.sh "$FUNCTIONS_FILE" && echo "Restored functions.sh" || echo "Failed to restore functions.sh"
cp -f settings.zsh "$ZSH_SETTINGS_FILE" && echo "Restored settings.zsh" || echo "Failed to restore settings.zsh"
cp -f setting.sh "$BASH_SETTINGS_FILE" && echo "Restored setting.sh" || echo "Failed to restore setting.sh"
#cp -f .env_vars "$ENV_VARS_FILE" && echo "Restored env_vars.sh" || echo "Failed to restore .env_vars"
cp -f .tmux.conf "$TMUX_FILE" && echo "Restored .tmux.conf" || echo "Failed to restore .tmux.conf"
#cp -f agnoster.zsh-theme "$AGNOSTER_THEME_FILE" && echo "Restored agnoster.zsh-theme" || echo "Failed to restore agnoster.zsh-theme"
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
