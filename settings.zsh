# 检查是否为交互式 shell，如果不是，直接返回
if [[ -o interactive ]]; then
    # continue
else
    return
fi

# 不保存重复的命令或以空格开头的命令到历史记录
# 在 zsh 中对应的选项是 HIST_IGNORE_DUPS 和 HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# 追加到历史记录文件而不是覆盖
setopt APPEND_HISTORY

# 设置历史记录的长度
HISTSIZE=1000
SAVEHIST=2000  





