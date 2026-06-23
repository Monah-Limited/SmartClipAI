
<p align="center">
  <img src="assets/banner.png" width="600" alt="SmartClipAI Banner">
</p>

<h1 align="center">SmartClipAI 🤖</h1>

<p align="center">
  <b>AI-powered clipboard assistant for macOS — translate, rewrite, summarize, explain code from your menu bar.</b><br>
  <b>AI 增强的 macOS 智能剪贴板助手 — 菜单栏一键翻译、润色、总结、解释代码。</b>
</p>

<p align="center">
  <a href="https://github.com/Monah-Limited/SmartClipAI/releases"><img src="https://img.shields.io/badge/Download-DMG-blue?style=for-the-badge&logo=apple" alt="Download DMG"></a>
  <a href="https://github.com/Monah-Limited/SmartClipAI/stargazers"><img src="https://img.shields.io/github/stars/Monah-Limited/SmartClipAI?style=for-the-badge&logo=github" alt="Stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="License"></a>
  <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.8+-green?style=for-the-badge&logo=python" alt="Python"></a>
  <a href="https://github.com/Monah-Limited/SmartClipAI/actions"><img src="https://img.shields.io/badge/Build-Passing-brightgreen?style=for-the-badge" alt="Build"></a>
</p>

---

## 📸 截图 / Screenshots

<p align="center">
  <img src="assets/screenshots/01_menu_dropdown.png" width="280" alt="Menu">
  <img src="assets/screenshots/02_translation_result.png" width="350" alt="Translate">
  <img src="assets/screenshots/03_settings_dialog.png" width="320" alt="Settings">
  <br>
  <img src="assets/screenshots/04_code_explanation.png" width="350" alt="Code Explain">
  <img src="assets/screenshots/06_features_showcase.png" width="400" alt="Features">
</p>

---

## ✨ 功能特性 / Features

| 图标 Icon | 功能 Feature | 中文说明 | English |
|:---:|---|---|---|
| 🌍 | **翻译 Translate** | 任意语言 → 简体中文 | Any language → English |
| ✍️ | **润色 Rewrite** | 零碎笔记 → 专业文案 | Rough notes → polished text |
| 📝 | **总结 Summarize** | 长文章 → 核心要点 | Long article → TL;DR |
| 💻 | **解释代码 Explain Code** | 任何代码 → 清晰解释 | Any code → clear explanation |
| 🤖 | **自由提问 Ask** | 基于剪贴内容任意提问 | Ask anything about clipboard |

---

## 🚀 一键安装 / One-Click Install

**中文：** 在终端运行以下命令，即可自动安装：

**English:** Run this in your terminal — it installs everything automatically:

```bash
curl -sfL https://raw.githubusercontent.com/Monah-Limited/SmartClipAI/main/scripts/install.sh | sh
```

<div align="center">
  <img src="assets/screenshots/05_architecture.png" width="700" alt="Architecture">
</div>

安装脚本会自动：
1. ✅ 检查 macOS 版本
2. ✅ 安装 Python 依赖（rumps, pyperclip）
3. ✅ 下载并安装 `SmartClipAI.app` 到 `/Applications`
4. ✅ 安装 `smartclipai` CLI 命令到 `/usr/local/bin`
5. ✅ 绕过 Gatekeeper（首次可直接双击打开）

---

## 💻 CLI 命令 / CLI Commands

安装后即可使用 `smartclipai` 命令行工具：

**中文：** SmartClipAI 提供完整的命令行支持，无需打开 GUI 即可使用。

**English:** SmartClipAI comes with a full CLI — no GUI needed for quick actions.

| 命令 Command | 中文说明 | English |
|---|---|---|
| `smartclipai start` | 启动菜单栏应用 | Launch the menu bar app |
| `smartclipai stop` | 退出应用 | Quit the app |
| `smartclipai status` | 查看运行状态 | Check running status |
| `smartclipai config` | 查看 API Key 状态 | Show API key status |
| `smartclipai config set <key>` | 设置 DeepSeek API Key | Set API key in Keychain |
| `smartclipai config delete` | 删除 API Key | Remove API key |
| `smartclipai translate <text>` | 快速翻译 | Quick translate |
| `smartclipai rewrite <text>` | 快速润色 | Quick rewrite |
| `smartclipai summarize <text>` | 快速总结 | Quick summarize |
| `smartclipai uninstall` | 完全卸载 | Complete uninstall |
| `smartclipai help` | 查看所有命令 | Show all commands |

### 使用示例 / Usage Examples

```bash
# 设置 API Key / Set API Key
smartclipai config set sk-your-deepseek-key-here

# 启动应用 / Start the app
smartclipai start

# 命令行快速翻译 / Quick translate from CLI
smartclipai translate "The quick brown fox jumps over the lazy dog"
# → 「敏捷的棕色狐狸跳过了懒狗」

# 命令行润色 / Polish text from CLI
smartclipai rewrite "this is a good app i like it"
# → "This is an excellent application. I thoroughly enjoy using it."

# 查看状态 / Check status
smartclipai status
```

---

## 📥 其他安装方式 / Alternative Installation

### DMG 安装 / DMG Installer

Download from [Releases](https://github.com/Monah-Limited/SmartClipAI/releases):

```bash
# Or use the CLI to install from a local build
smartclipai install
```

### 源码运行 / Run from Source

```bash
git clone https://github.com/Monah-Limited/SmartClipAI.git
cd SmartClipAI
pip install -r requirements.txt
python src/smartclipai.py
```

---

## 🔧 技术栈 / Tech Stack

| 中文 | English | 用途 Purpose |
|------|---------|-------------|
| [rumps](https://github.com/jaredks/rumps) | macOS Menu Bar Framework | 菜单栏界面 |
| [pyperclip](https://github.com/asweigart/pyperclip) | Clipboard Access | 剪贴板读写 |
| [DeepSeek](https://platform.deepseek.com) V4 Flash API | AI Engine | 翻译/润色/总结/代码解释 |
| [pyobjc](https://github.com/ronaldoussoren/pyobjc) | macOS Native Bindings | 系统原生交互 |
| macOS Keychain | Secure Storage | API Key 安全存储 |

---

## 🧠 "30 Apps in 100 Days" / 30 Apps in 100 Days

**中文：** 这是 **30 Apps in 100 Days** 挑战的 Day 1 作品。100天内发布 30 个高质量的 macOS 开源工具。

**English:** This is Day 1 of the **30 Apps in 100 Days** challenge — publishing 30 high-quality open-source apps in 100 days.

> 关注旅程 / Follow the journey: [@timwynter](https://github.com/timwynter) on GitHub

---

## 🤝 贡献 / Contributing

**中文：** PR 欢迎！可以添加的新功能方向：

**English:** PRs welcome! Ideas for new features:

| 中文 | English |
|------|---------|
| 🎨 格式化 JSON/XML/代码 | Format JSON/XML/code |
| 🔍 语法检查 | Grammar check |
| 🌐 多语言翻译 | Multi-language translation |
| 📧 写邮件回复 | Write email replies |
| 🖼️ OCR 图片文字识别 | OCR image text |

---

## 🙏 Credits / 致谢

This project stands on these open-source projects:

| Project | What it does |
|---------|-------------|
| [**rumps**](https://github.com/jaredks/rumps) | macOS menu bar framework |
| [**PyObjC**](https://github.com/ronaldoussoren/pyobjc) | Python-ObjectiveC bridge for `NSPasteboard` |
| [**OpenAI**](https://platform.openai.com) | Chat & translation API |
| [**DeepSeek**](https://platform.deepseek.com) | Chat & translation API |
| [**Anthropic Claude**](https://www.anthropic.com/api) | Chat & analysis API |
| [**pyperclip**](https://github.com/asweigart/pyperclip) | Cross-platform clipboard access |
| [**macOS Menu Bar Apps**](https://github.com/Monah-Limited?q=&type=&language=&sort=) | Sister projects in the Monah ecosystem |

---

## 🇨🇳 中文

<p align="center">
  <b><a href="#-english">← English</a> · 中文</b>
</p>

**SmartClipAI** — macOS 菜单栏 AI 剪贴板助手：翻译、改写、总结、解释代码。

### 功能

- 📋 监听剪贴板变化
- 🌐 多语言翻译
- ✍️ AI 改写润色
- 📝 智能摘要
- 💻 代码解释

### 键盘快捷键

| 快捷键 | 功能 |
|--------|------|
|  | 翻译选中文本 |
|  | 改写润色 |
|  | 总结摘要 |
|  | 解释代码 |

### 致谢

感谢 [rumps](https://github.com/jaredks/rumps)（macOS 菜单栏框架）、[OpenAI](https://platform.openai.com)、[DeepSeek](https://platform.deepseek.com)、[Anthropic](https://www.anthropic.com/api) 提供的 AI API。

---

## 📄 许可证 / License

**中文：** MIT 许可证 — 可自由使用、修改、分发。

**English:** MIT License — free to use, modify, and distribute.

---

<p align="center">
  <img src="assets/banner.png" width="400" alt="SmartClipAI">
  <br>
  <b>⭐ 如果对你有帮助，请点个 Star！</b>
  <br>
  <b>If you find this useful, please give it a star!</b>
</p>

---

**#macOS #clipboard #AI #menubar #translate #rewrite #summarize #deepseek #python #opensource #productivity #tools**
