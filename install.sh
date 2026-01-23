#!/bin/sh
# 一键安装/更新脚本

set -e

echo "=== env-prefix 安装/更新 ==="

# 1. 创建配置目录
mkdir -p ~/.env-prefix

# 2. 复制配置文件
echo "复制配置文件到 ~/.env-prefix/ ..."
cp -v config/*.env ~/.env-prefix/

# 3. 创建符号链接
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_SCRIPT="$SCRIPT_DIR/bin/envp"

echo "创建符号链接到 $BIN_DIR ..."
ln -sf "$SOURCE_SCRIPT" "$BIN_DIR/envp"
ln -sf "$SOURCE_SCRIPT" "$BIN_DIR/sonnet"

# 4. 检查 PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    echo ""
    echo "⚠️  请将以下内容添加到你的 ~/.zshrc 或 ~/.bashrc："
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo "✅ 安装完成！"
echo ""
echo "使用方法："
echo "  claude              # 直接使用 claude"
echo "  sonnet claude       # 使用 AWS Bedrock"
echo ""
echo "更新配置："
echo "  1. 编辑 config/*.env"
echo "  2. 运行 ./install.sh 更新"
