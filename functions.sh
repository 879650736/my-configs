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
    ln -s "$PWD" ~/"Desktop/$dir_name" || { echo "Failed to create symlink on Desktop"; return 1; }
    echo "Shortcut to $dir_name created on Desktop."
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

}

