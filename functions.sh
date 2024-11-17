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
    export http_proxy="http://127.0.0.1:7897"
    export https_proxy="http://127.0.0.1:7897"
    export all_proxy="socks5://127.0.0.1:7897"
    echo "HTTP HTTPS SOCKS5 代理已设置为 http://127.0.0.1:7897"
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
    unset all_proxy
    echo "HTTP 和 HTTPS SOCKS5 代理已取消"
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
    ~/my_configs/update_configs.sh
}

# 定义 mkcd 函数
mkcd() {
    mkdir -p "$1" && cd "$1"
}


update_git_remote_pwd() {
    REPO_DIR=$(pwd)

    DATE=$(date +"%Y-%m-%d %H:%M:%S")
    COMMIT_MESSAGE="Update compiler files at $DATE"

    # 切换到目标目录
    cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; return 1; }

    # 添加更改到 Git
    git add * || { echo "Failed to add changes to git"; return 1; }

    # 提交更改
    git commit -m "$COMMIT_MESSAGE" || { echo "Failed to commit changes"; return 1; }

    # 推送更改到远程仓库
    git push -u origin master || { echo "Failed to push changes to remote repository"; return 1; }

    echo "Update completed successfully."
}

link_to_desktop() {
    local dir_name=$(basename "$PWD")
    local desktop_file=~/"Desktop/$dir_name.desktop"

    # 创建 .desktop 文件
    echo "[Desktop Entry]" > "$desktop_file"
    echo "Name=$dir_name" >> "$desktop_file"
    echo "Comment=Shortcut to the $dir_name directory" >> "$desktop_file"
    echo "Exec=nautilus $PWD" >> "$desktop_file"
    echo "Icon=folder" >> "$desktop_file"
    echo "Terminal=false" >> "$desktop_file"
    echo "Type=Application" >> "$desktop_file"

    chmod +x "$desktop_file"

    echo "Shortcut $desktop_file created."
}

# 列出所有进程并查看指定 PID 的 maps 信息
function list_and_view_maps() {
    # 列出所有进程及其 PID
    echo "Listing all processes:"
    ps -eo pid,comm --sort=pid  # 列出 PID 和命令，按 PID 排序
    echo  # 添加空行以便更清晰

    # 提示用户输入 PID
    echo -n "Enter the PID you want to view maps for: "
    read pid  # 等待用户输入 PID

    # 检查进程是否存在
    if ! kill -0 "$pid" 2>/dev/null; then
        echo "Process with PID $pid does not exist."
        return 1
    fi

    # 输出 maps 信息
    echo "Memory maps for PID $pid:"
    cat "/proc/$pid/maps"
}

# 列出所有进程并查看指定 PID 的 maps 信息
list_and_view_maps() {
    # 列出所有进程及其 PID
    echo "Listing all processes:"
    ps -eo pid,comm --sort=pid  # 列出 PID 和命令，按 PID 排序
    echo  # 添加空行以便更清晰

    # 提示用户输入 PID
    echo -n "Enter the PID you want to view maps for: "
    read pid  # 等待用户输入 PID

    # 检查进程是否存在
    if ! kill -0 "$pid" 2>/dev/null; then
        echo "Process with PID $pid does not exist."
        return 1
    fi

    # 输出 maps 信息
    echo "Memory maps for PID $pid:"
    cat "/proc/$pid/maps"
}


# 定义变量
SSH="ubuntu@170.106.189.30"

# 连接到远程服务器的函数
ssh_connect() {
    ssh "$SSH"
}

sync_to_remote() {
    local src_file="$1"
    if [ -z "$src_file" ]; then
        echo "请提供要传输的文件路径。"
        return 1
    fi
    rsync -avz "$src_file" "$SSH:~/"
}

extract() {
    local file="$1"
    if [ -z "$file" ]; then
        echo "请提供要解压的文件路径。"
        return 1
    fi

    if [ ! -f "$file" ]; then
        echo "文件不存在：$file"
        return 1
    fi

    case "$file" in
        *.tar.gz | *.tgz) tar -xvzf "$file" ;;
        *.tar.bz2) tar -xvjf "$file" ;;
        *.tar.xz) tar -xvJf "$file" ;;
        *.tar) tar -xvf "$file" ;;
        *.gz) gunzip "$file" ;;
        *.zip) unzip "$file" ;;
        *.bz2) bunzip2 "$file" ;;
        *.xz) unxz "$file" ;;
        *) echo "不支持的文件格式：$file" ;;
    esac
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
    echo "mkcd:建立并进入文件夹"
    echo "update_git_remote_pwd:更新当前文件夹的远程github目录"
    echo "link_to_desktop:将当前文件夹的快捷方式放入桌面"
    echo "list_and_view_maps:列出所有进程并查看指定 PID 的 maps 信息"
    echo "ssh_connect:链接到远程服务器"
    echo "sync_to_remote:上传文件至远程服务器"
    echo "extract:解压文件"

}

