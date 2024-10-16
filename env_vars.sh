# 载入 Rust 的环境变量（由 cargo 提供）
source "$HOME/.cargo/env"

# 注意 $HOME 是 Linux 自动设置的表示你家目录的环境变量，你也可以根据实际位置灵活调整
export PATH="$HOME/os_env/qemu-7.0.0/build/:$PATH"
export PATH="$HOME/os_env/qemu-7.0.0/build/riscv64-softmmu:$PATH"
export PATH="$HOME/os_env/qemu-7.0.0/build/riscv64-linux-user:$PATH"
export PATH="$HOME/os_env/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14/bin/:$PATH"

# 添加 Android Studio 的二进制目录到 PATH
export PATH=$PATH:/home/ssy/android_studio/android-studio-2024.1.2.12-linux/android-studio/bin

# 设置 NVM 环境变量并加载 nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # 加载 nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # 加载 nvm bash 补全

#source /home/ssy/.config/broot/launcher/bash/br 
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

source /home/ssy/.config/broot/launcher/bash/br

# Rust 国内镜像
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup

# Java 环境变量
export JAVA_HOME='/opt/jdk-13.0.1'
export PATH="$JAVA_HOME/bin:$PATH"

# Maven 环境变量
export M2_HOME='/opt/apache-maven-3.9.9'
export PATH="$M2_HOME/bin:$PATH"

