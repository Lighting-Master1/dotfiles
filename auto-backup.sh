#!/bin/bash

# 进入 dotfiles 目录
cd ~/dotfiles

# 备份核心配置文件
echo "备份核心配置文件..."
cp ~/.bashrc ~/dotfiles/bashrc
cp ~/.gitconfig ~/dotfiles/gitconfig

# 备份 GNOME 快捷键设置
if command -v dconf &> /dev/null; then
  echo "备份 GNOME 快捷键设置..."
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ~/dotfiles/gnome-keybindings.dconf
fi

# 备份系统网络设置
echo "备份系统网络设置..."
if [ -f /etc/netplan/*.yaml ]; then
  cp /etc/netplan/*.yaml ~/dotfiles/netplan/
fi

# 备份系统时区设置
echo "备份系统时区设置..."
timedatectl show > ~/dotfiles/timedatectl.conf

# 备份已安装的软件包列表
echo "备份已安装的软件包列表..."
dpkg --get-selections > ~/dotfiles/installed-packages.list

# 备份系统环境变量
echo "备份系统环境变量..."
env > ~/dotfiles/environment-variables.txt

# 备份系统服务状态
echo "备份系统服务状态..."
systemctl list-unit-files --type=service > ~/dotfiles/system-services.txt

# 备份系统 crontab 任务
echo "备份系统 crontab 任务..."
crontab -l > ~/dotfiles/crontab-backup.txt

# 检查是否有文件变化
if git diff --quiet; then
  echo "无文件变化，跳过提交。"
else
  # 提交到 Git 仓库
  echo "提交到 Git 仓库..."
  git add .
  git commit -m "自动备份配置文件 $(date +'%Y-%m-%d %H:%M:%S')"
  git push origin master
fi

echo "自动备份完成！"
