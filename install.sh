#!/bin/sh
# 一键安装/更新脚本

set -e

echo "=== env-prefix 安装/更新 ==="
echo ""

# 1. 创建配置目录
mkdir -p ~/.env-prefix

# 2. 复制配置文件
echo "📦 复制配置文件到 ~/.env-prefix/ ..."
if ls config/*.env >/dev/null 2>&1; then
    cp -v config/*.env ~/.env-prefix/
else
    echo "   ⚠️  没有找到 .env 文件，请先创建配置文件"
    exit 1
fi
echo ""

# 3. 创建符号链接
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_SCRIPT="$SCRIPT_DIR/bin/envp"

echo "🔗 创建符号链接到 $BIN_DIR ..."
ln -sf "$SOURCE_SCRIPT" "$BIN_DIR/envp"

# 只为项目里的 .env 文件创建符号链接
for env_file in config/*.env; do
    if [ -f "$env_file" ]; then
        env_name=$(basename "$env_file" .env)
        ln -sf "$SOURCE_SCRIPT" "$BIN_DIR/$env_name"
        echo "   ✓ $env_name"
    fi
done
echo ""

# 4. 检查并自动添加 PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "⚠️  检测到 PATH 中没有 $BIN_DIR"
    echo ""
    
    # 检测 shell 类型
    SHELL_RC=""
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    fi
    
    if [ -n "$SHELL_RC" ]; then
        printf "是否自动添加到 %s? (y/n): " "$SHELL_RC"
        read -r reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
            echo "✅ 已添加到 $SHELL_RC"
            echo "   请运行: source $SHELL_RC"
        else
            echo "请手动添加以下内容到 $SHELL_RC："
            echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
        fi
    else
        echo "请手动添加以下内容到你的 ~/.zshrc 或 ~/.bashrc："
        echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
    echo ""
fi

echo "✅ 安装完成！"
echo ""
echo "📋 可用环境列表："
for env_file in config/*.env; do
    if [ -f "$env_file" ]; then
        env_name=$(basename "$env_file" .env)
        echo "   • $env_name claude       # 使用 $env_name 环境"
    fi
done
echo "   • claude             # 直接使用 claude（无环境配置）"
echo ""
echo "💡 更新配置："
echo "   1. 编辑 config/*.env"
echo "   2. 运行 ./install.sh 更新"
