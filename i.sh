#!/usr/bin/env bash
set -e

# Function to install curl if missing
install_curl() {
    if command -v curl >/dev/null 2>&1; then
        echo "✅ curl 已安装，跳过安装"
        return
    fi

    echo "⚠️ curl 未安装，尝试安装..."
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y curl
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y curl
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm curl
    else
        echo "❌ 找不到支持的包管理器，请手动安装 curl"
        exit 1
    fi
}

# 安装 curl（如果已存在则跳过）
install_curl

# URL of the 奥科戈 binary
URL="https://aokege.foo.ng/aokege-linux-x86_64"

# Destination file name
BIN_NAME="奥科戈"

# Temporary download location
TMP_FILE="/tmp/$BIN_NAME"

echo "⬇️  下载奥科戈..."
curl -L "$URL" -o "$TMP_FILE"

echo "🔧 设置可执行权限..."
chmod +x "$TMP_FILE"

echo "📦 安装到 /usr/local/bin..."
sudo mv "$TMP_FILE" /usr/local/bin/"$BIN_NAME"

echo "✅ 安装完成！你可以运行 '奥科戈 --help' 来测试"
