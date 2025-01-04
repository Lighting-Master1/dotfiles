#!/bin/bash

# 创建软链接
echo "创建软链接..."
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/config/ ~/.config/
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/ssh/ ~/.ssh/

# 恢复 GNOME 设置
if [ -f ~/dotfiles/gnome-settings.dconf ]; then
  echo "恢复 GNOME 设置..."
  dconf load / < ~/dotfiles/gnome-settings.dconf
fi

# 恢复 GNOME 快捷键
if [ -f ~/dotfiles/gnome-keybindings.dconf ]; then
  echo "恢复 GNOME 快捷键..."
  dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/dotfiles/gnome-keybindings.dconf
fi

# 提示完成
echo "Dotfiles 安装完成！"
