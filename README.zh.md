
<p align="center">
  <img src="assets/banner.png" width="600" alt="SmartClipAI 横幅">
</p>

<h1 align="center">SmartClipAI 🤖</h1>

<p align="center">
  <b>AI 增强的 macOS 智能剪贴板助手 — 菜单栏一键翻译、润色、总结、解释代码。</b><br>
  <b>AI-powered clipboard assistant for macOS — translate, rewrite, summarize, explain code from your menu bar.</b>
</p>

<p align="center">
  <a href="https://github.com/monah-studio/SmartClipAI/releases"><img src="https://img.shields.io/badge/下载-DMG-blue?style=for-the-badge&logo=apple" alt="下载 DMG"></a>
  <a href="https://github.com/monah-studio/SmartClipAI/stargazers"><img src="https://img.shields.io/github/stars/monah-studio/SmartClipAI?style=for-the-badge&logo=github" alt="Stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/许可证-MIT-yellow?style=for-the-badge" alt="许可证"></a>
  <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.8+-green?style=for-the-badge&logo=python" alt="Python"></a>
</p>

---

## 📸 截图预览

<p align="center">
  <img src="assets/screenshots/01_menu_dropdown.png" width="280" alt="菜单栏">
  <img src="assets/screenshots/02_translation_result.png" width="350" alt="翻译结果">
  <img src="assets/screenshots/03_settings_dialog.png" width="320" alt="设置界面">
  <br>
  <img src="assets/screenshots/04_code_explanation.png" width="350" alt="代码解释">
  <img src="assets/screenshots/06_features_showcase.png" width="400" alt="功能一览">
</p>

---

## ✨ 功能特性

| 图标 | 功能 | 说明 |
|:---:|------|------|
| 🌍 | **翻译** | 任意语言 → 简体中文 |
| ✍️ | **润色** | 零碎笔记 → 专业文案 |
| 📝 | **总结** | 长文章 → 核心要点 |
| 💻 | **解释代码** | 任何代码 → 清晰解释 |
| 🤖 | **自由提问** | 基于剪贴内容任意提问 |

---

## 🚀 快速开始

### 方式一：下载 DMG（推荐）

从 [Releases 页面](https://github.com/monah-studio/SmartClipAI/releases) 下载最新的 `.dmg` 文件，打开并将 SmartClipAI.app 拖入 Applications 文件夹。

```bash
# 首次打开需要：右键 → 打开（因未签名）
# First time: right-click → Open (unsigned app)
```

<div align="center">
  <img src="assets/screenshots/05_architecture.png" width="700" alt="系统架构">
</div>

### 方式二：源码运行

```bash
git clone https://github.com/monah-studio/SmartClipAI.git
cd SmartClipAI
pip install -r requirements.txt
python src/smartclipai.py
```

### 2. 配置 API Key

点击菜单栏 📋 图标 → **设置** → 输入你的 DeepSeek API Key。
Key 会安全存储在 **macOS Keychain** 中，不会明文保存。

> 💡 **获取 API Key:** [platform.deepseek.com](https://platform.deepseek.com)
>
> 💰 **价格:** DeepSeek V4 Flash — ~¥1 / 1M input tokens, ~¥2 / 1M output tokens（极低价格）

### 3. 使用步骤

```
1. 复制任意文本（Cmd+C）
2. 点击菜单栏 📋 图标
3. 选择操作：翻译 / 润色 / 总结 / 解释代码 / 自由提问
4. 结果弹出窗口显示
5. 点击"复制结果"保存到剪贴板
```

---

## 🔧 技术栈

| 库 | 用途 |
|----|------|
| [rumps](https://github.com/jaredks/rumps) | macOS 菜单栏界面框架 |
| [pyperclip](https://github.com/asweigart/pyperclip) | 跨平台剪贴板读写 |
| [DeepSeek](https://platform.deepseek.com) V4 Flash API | AI 引擎（翻译/润色/总结/代码解释） |
| [pyobjc](https://github.com/ronaldoussoren/pyobjc) | macOS 原生 API 绑定 |
| macOS Keychain | API Key 安全存储 |

---

## 📦 生成 DMG 安装包

```bash
make dmg
```

DMG 文件生成在 `dist/SmartClipAI.dmg`。

---

## 🧠 "30 Apps in 100 Days"

这是 **30 Apps in 100 Days** 挑战的 Day 1 作品。100 天内发布 30 个高质量的 macOS 开源工具。

> 关注旅程: [@timwynter](https://github.com/timwynter)

---

## 🤝 贡献

欢迎 PR！可添加的功能方向：

- 🎨 格式化 JSON/XML/代码
- 🔍 语法检查
- 🌐 多语言翻译
- 📧 写邮件回复
- 🖼️ OCR 图片文字识别

---

## 📄 许可证

MIT 许可证 — 可自由使用、修改、分发。

---

<p align="center">
  <img src="assets/banner.png" width="400" alt="SmartClipAI">
  <br>
  <b>⭐ 如果对你有帮助，请点个 Star！</b>
</p>
