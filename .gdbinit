source ~/.gef-2025.01.py
# 禁用分页显示（避免长输出时暂停）
set pagination off

# 设置 Intel 风格汇编语法
set disassembly-flavor intel

# 允许加载当前目录的.gdbinit文件
set auto-load safe-path .

# 自定义内存打印命令
define pmem
  if $argc == 2
    x/$arg0xg $arg1
  else
    printf "Usage: pmem [COUNT] [ADDRESS]\n"
  end
end

