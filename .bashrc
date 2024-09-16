# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='exa -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"


# 添加到 ~/.bashrc 的测试脚本

git_clone_and_remove() {
  local repo_url="https://github.com/octocat/Hello-World.git"
  local clone_dir="test_repo"

  # 克隆仓库
  echo "Cloning repository from $repo_url..."
  git clone $repo_url $clone_dir

  # 检查克隆是否成功
  if [ -d "$clone_dir" ]; then
    echo "Repository cloned successfully to $clone_dir."

    # 移除克隆的目录
    echo "Removing cloned directory $clone_dir..."
    rm -rf $clone_dir

    # 检查目录是否成功移除
    if [ ! -d "$clone_dir" ]; then
      echo "Cloned directory removed successfully."
    else
      echo "Failed to remove cloned directory."
    fi
  else
    echo "Failed to clone repository."
  fi
}

cleanup_apt_locks() {
    echo "查找并终止卡住的 apt 和 dpkg 进程..."
    sudo ps aux | grep -E 'apt|dpkg' | grep -v grep
    echo "请输入要终止的进程ID（PID），以空格分隔（例如：1234 5678）："
    read pids
    for pid in $pids; do
        sudo kill -9 $pid
    done

    echo "移除锁文件..."
   sudo rm /var/lib/dpkg/lock-frontend
   sudo rm /var/lib/dpkg/lock
   sudo rm /var/cache/apt/archives/lock
    echo "重新配置 dpkg..."
    sudo dpkg --configure -a

    echo "清理部分安装的包..."
    sudo apt-get clean
    sudo apt-get autoclean
    sudo apt-get autoremove

    echo "完成！"
}

set_proxy() {
    export http_proxy="http://127.0.0.1:12333"
    export https_proxy="http://127.0.0.1:12333"
    echo "HTTP 和 HTTPS 代理已设置为 http://127.0.0.1:12333"
}

rd_set_proxy() {
    export http_proxy="http://192.168.43.1:12345"
    export https_proxy="http://192.168.43.1:12345"

    echo "HTTP 和 HTTPS 代理已设置为http://192.168.43.1:12345"
}


# 取消代理的函数
unset_proxy() {
    unset http_proxy
    unset https_proxy
    echo "HTTP 和 HTTPS 代理已取消"
}

check_and_kill_port() {
    if [ -z "$1" ]; then
        echo "用法: check_and_kill_port <端口号>"
        return 1
    fi

    PORT=$1

    echo "检查端口 $PORT 的占用情况..."
    lsof -i :$PORT

    echo "请输入要终止的进程ID（PID），或者按 Enter 键跳过终止操作："
    read pid

    if [ -n "$pid" ]; then
        echo "终止进程 $pid..."
        sudo kill -9 $pid
        echo "进程 $pid 已终止。"
    else
        echo "没有进程被终止。"
    fi
}

add_to_path() {
    echo 'export PATH=$PATH:'"$PWD" >> ~/.bashrc
    source ~/.bashrc
    echo "Current directory ($PWD) added to PATH."
}

# Function to run the update-configs.sh script
update_configs() {
    ~/my-configs/update-configs.sh
}


list_defined_functions() {
    echo "以下是已定义的函数："

    # 列出函数名称及其描述
    echo "git_clone_and_remove: 克隆一个 Git 仓库到指定目录，然后删除该目录。"
    echo "cleanup_apt_locks: 查找并终止卡住的 apt 和 dpkg 进程，移除锁文件，重新配置 dpkg，并清理部分安装的包。"
    echo "set_proxy: 设置 HTTP 和 HTTPS 代理。"
    echo "unset_proxy: 取消 HTTP 和 HTTPS 代理。"
    echo "check_and_kill_port: 检查指定端口的占用情况，并根据用户输入终止相应的进程。"
    echo "add_to_path:将pwd的目录放入环境变量里"
    echo "update_configs:在github里更新my_configs"

    # 提示用户是否要列出所有函数名
    echo "是否要列出所有定义的函数名称？（输入 't' 或 'T' 来执行，其他键跳过）："
    read user_input

    if [[ "$user_input" == "t" || "$user_input" == "T" ]]; then
        echo "所有定义的函数名称如下："
        declare -F | awk '{print $3}'
    else
        echo "跳过列出所有函数名称。"
    fi
}

# 注意 $HOME 是 Linux 自动设置的表示你家目录的环境变量，你也可以根据实际位置灵活调整
export PATH="$HOME/os-env/qemu-7.0.0/build/:$PATH"
export PATH="$HOME/os-env/qemu-7.0.0/build/riscv64-softmmu:$PATH"
export PATH="$HOME/os-env/qemu-7.0.0/build/riscv64-linux-user:$PATH"
export PATH="$HOME/gnu/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14/bin/:$PATH"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#source /home/ssy/.config/broot/launcher/bash/br 

# 定义 mkcd 函数
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# 创建常用命令的缩写
alias ll="exa -lh"
alias ..='cd ..'
alias path='echo $PATH | tr ":" "\n" | awk '\''{
    colors[1]="\033[31m"; # Red
    colors[2]="\033[32m"; # Green
    colors[3]="\033[33m"; # Yellow
    colors[4]="\033[34m"; # Blue
    colors[5]="\033[35m"; # Magenta
    colors[6]="\033[36m"; # Cyan
    colors[7]="\033[37m"; # White
    print colors[(NR % 7) + 1] $0 "\033[0m"
}'\'


# 能够少输入很多
alias gs="git status"
alias gc="git commit"
alias ga="git add ./"
alias gl="git log --all --graph --decorate"
alias gb="git branch"
alias gch="git checkout"
alias v="vim"
alias br='broot'

# 手误打错命令也没关系
alias sl=ls
alias dc=cd

# 重新定义一些命令行的默认行为
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format

# 更新tmux conf
alias vtmux="v ~/.tmux.conf"
alias tmuxupdate="tmux source-file ~/.tmux.conf"

# 更新bashrc
alias vbash="v ~/.bashrc"
alias bashupdate="source ~/.bashrc"

# 更新vimrc
alias vvim="v ~/.vimrc"
alias vimupdate="source ~/.vimrc"

#更新docker
alias vdocker='v /etc/apt/sources.list.d/docker.list'

#更新gitconfig
alias vgit="v ~/.gitconfig"

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

#更新Ubuntu
alias update='sudo apt update -y'
alias upgrade='sudo apt upgrade -y'

#打开docker
alias dockerstart='sudo service docker start'
alias dockerrestart='sudo service docker restart'
alias dockerstop='sudo service docker stop'
alias dockerls='docker images'
alias compiler='docker run -it --rm -v /home/ssy/compiler:/root/compiler maxxing/compiler-dev bash'

#curl
alias curlg='curl google.com'
alias curlb='curl baidu.com' 

#更改ctags默认行为
alias ctags='ctags -R .'
alias lstags='exa -l tags'

#更改updatedb默认行为
alias updatedb='sudo updatedb'

source /home/ssy/.config/broot/launcher/bash/br

alias search_spark='aptss search --full --names-only'
alias install_spark='sudo aptss install'
alias docker_service='cd /etc/systemd/system/docker.service.d'

export PATH=$PATH:/home/ssy/android_studio/android-studio-2024.1.2.12-linux/android-studio/bin

alias cl='clear'
alias code.='code .'
