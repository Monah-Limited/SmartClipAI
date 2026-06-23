#!/usr/bin/env bash
# ============================================================================
# SmartClipAI — One-Line Installer
# ============================================================================
# Usage:
#   curl -sfL https://raw.githubusercontent.com/monah-studio/SmartClipAI/main/scripts/install.sh | sh
#
# Or from this repo directly:
#   bash scripts/install.sh
# ============================================================================

set -euo pipefail

REPO="monah-studio/SmartClipAI"
VERSION="v1.0.0"
APP_NAME="SmartClipAI"
APP_DIR="/Applications/$APP_NAME.app"
CLI_INSTALL_DIR="/usr/local/bin"

# ── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()  { printf "${BLUE}🔵 %s${NC}\n" "$*"; }
ok()    { printf "${GREEN}✅ %s${NC}\n" "$*"; }
warn()  { printf "${YELLOW}⚠️  %s${NC}\n" "$*"; }
error() { printf "${RED}❌ %s${NC}\n" "$*"; exit 1; }

# ── Header ──────────────────────────────────────────────────────────────────
echo ""
info "========================================"
info "  SmartClipAI Installer v1.0.0"
info "  AI-powered clipboard assistant for macOS"
info "========================================"
echo ""

# ── OS Check ────────────────────────────────────────────────────────────────
OS="$(uname -s)"
if [ "$OS" != "Darwin" ]; then
    error "SmartClipAI only supports macOS. Detected: $OS"
fi

MACOS_VERSION="$(sw_vers -productVersion 2>/dev/null || echo "unknown")"
info "macOS version: $MACOS_VERSION"

ARCH="$(uname -m)"
info "Architecture: $ARCH"

# ── Python Check ────────────────────────────────────────────────────────────
PYTHON=""
for py in "/opt/homebrew/bin/python3.11" "/opt/homebrew/bin/python3.12" \
          "/usr/local/bin/python3.11" "/opt/homebrew/bin/python3" \
          "/usr/bin/python3" "$HOME/.hermes/hermes-agent/venv/bin/python3"; do
    if [ -x "$py" ] && "$py" -c "import sys; sys.exit(0 if sys.version_info >= (3,8) else 1)" 2>/dev/null; then
        PYTHON="$py"
        break
    fi
done

if [ -z "$PYTHON" ]; then
    warn "Python 3.8+ not found. Installing via Homebrew..."
    if command -v brew &>/dev/null; then
        brew install python@3.11
        PYTHON="/opt/homebrew/bin/python3.11"
    else
        error "Please install Python 3.8+ first: https://www.python.org/downloads/"
    fi
else
    PY_VER="$($PYTHON --version 2>&1)"
    ok "Python found: $PY_VER at $PYTHON"
fi

# ── Install Python Dependencies ────────────────────────────────────────────
info "Installing Python dependencies..."
$PYTHON -m pip install rumps pyperclip Pillow --quiet 2>/dev/null || true

if $PYTHON -c "import rumps; import pyperclip; from PIL import Image; print('✓ rumps, pyperclip, Pillow')" 2>/dev/null; then
    ok "Python dependencies installed"
else
    warn "Some dependencies need manual install. Run: pip install -r requirements.txt"
fi

# ── Download & Install .app ────────────────────────────────────────────────
DOWNLOAD_URL="https://github.com/$REPO/releases/download/$VERSION/${APP_NAME}.dmg"
TMP_DMG="/tmp/${APP_NAME}.dmg"

if [ -d "$APP_DIR" ]; then
    warn "$APP_NAME.app already exists in /Applications. Reinstalling..."
    rm -rf "$APP_DIR"
fi

info "Downloading $APP_NAME $VERSION..."
if command -v curl &>/dev/null; then
    curl -sfL "$DOWNLOAD_URL" -o "$TMP_DMG"
elif command -v wget &>/dev/null; then
    wget -q "$DOWNLOAD_URL" -O "$TMP_DMG"
else
    error "Neither curl nor wget found. Please install curl."
fi

if [ ! -f "$TMP_DMG" ] || [ ! -s "$TMP_DMG" ]; then
    error "Download failed. Check your internet connection."
fi

info "Installing $APP_NAME.app..."
# Attach DMG, copy app
MOUNT_POINT=$(mktemp -d)
hdiutil attach "$TMP_DMG" -mountpoint "$MOUNT_POINT" -nobrowse -quiet 2>/dev/null || {
    # Try modern diskutil method
    diskutil image mount "$TMP_DMG" 2>/dev/null || true
    MOUNT_POINT="/Volumes/$APP_NAME"
}

if [ -d "$MOUNT_POINT/$APP_NAME.app" ]; then
    cp -R "$MOUNT_POINT/$APP_NAME.app" /Applications/
elif [ -d "/Volumes/$APP_NAME/$APP_NAME.app" ]; then
    cp -R "/Volumes/$APP_NAME/$APP_NAME.app" /Applications/
fi

# Detach
hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || diskutil unmount "$MOUNT_POINT" 2>/dev/null || true
rm -f "$TMP_DMG"
rmdir "$MOUNT_POINT" 2>/dev/null || true

# Gatekeeper bypass
xattr -dr com.apple.quarantine "$APP_DIR" 2>/dev/null || true
spctl --add "$APP_DIR" 2>/dev/null || true

if [ -d "$APP_DIR" ]; then
    ok "$APP_NAME.app installed to /Applications"
else
    error "Installation failed. Please download the DMG manually."
fi

# ── Install CLI ─────────────────────────────────────────────────────────────
info "Installing 'smartclipai' CLI command..."

CLI_SCRIPT="$CLI_INSTALL_DIR/smartclipai"

# Download the CLI script
CLI_URL="https://raw.githubusercontent.com/$REPO/main/scripts/smartclipai"
if command -v curl &>/dev/null; then
    curl -sfL "$CLI_URL" -o "$CLI_SCRIPT" 2>/dev/null || {
        warn "Could not download CLI script. You can still use the .app directly."
        CLI_INSTALLED=false
    }
elif command -v wget &>/dev/null; then
    wget -q "$CLI_URL" -O "$CLI_SCRIPT" 2>/dev/null || {
        warn "Could not download CLI script."
        CLI_INSTALLED=false
    }
fi

if [ -f "$CLI_SCRIPT" ]; then
    chmod +x "$CLI_SCRIPT"
    ok "CLI installed: smartclipai"
    CLI_INSTALLED=true
fi

# ── Summary ─────────────────────────────────────────────────────────────────
echo ""
ok "============================================"
ok "  SmartClipAI 安装完成 / Installation Complete!"
ok "============================================"
echo ""
echo "  📦 App: /Applications/SmartClipAI.app"
echo ""
if [ "$CLI_INSTALLED" = true ]; then
    echo "  💻 CLI:  smartclipai"
    echo "           smartclipai help    — 查看帮助"
    echo "           smartclipai start   — 启动应用"
    echo "           smartclipai config  — 设置 API Key"
    echo ""
fi
echo "  🔑 首次使用请设置 API Key:"
echo "     点击菜单栏 📋 → 设置 → 输入 DeepSeek API Key"
echo "     或在命令行: smartclipai config set <your-key>"
echo ""
echo "  启动应用: open /Applications/SmartClipAI.app"
echo ""
info "  ⭐ 如果喜欢，请点个 Star: https://github.com/$REPO"
echo ""
