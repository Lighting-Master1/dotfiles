#!/bin/bash

# 设置 Git 用户名和邮箱
GIT_USERNAME="Lighting-Master1"
GIT_EMAIL="315023164@qq.com"

# 配置 Git 全局用户名和邮箱
echo "正在配置 Git 全局用户名和邮箱..."
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

# 检查是否已存在 SSH 密钥
if [ -f ~/.ssh/id_ed25519 ]; then
  echo "SSH 密钥已存在，路径为 ~/.ssh/id_ed25519"
else
  # 生成 SSH 密钥
  echo "正在生成 SSH 密钥..."
  ssh-keygen -t ed25519 -C "$GIT_EMAIL"
fi

# 显示公钥内容
echo "以下是你的公钥内容，请复制并添加到 GitHub："
cat ~/.ssh/id_ed25519.pub

# 启动 SSH 代理并添加密钥
echo "正在启动 SSH 代理并添加密钥..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 测试 SSH 连接
echo "正在测试 SSH 连接..."
ssh -T git@github.com

echo "脚本执行完成！"
