# 🚀 Neovim Mobile & Backend Development Setup

> **Professional-grade Neovim configuration for Android/KMP + Spring Boot development**

[![Neovim](https://img.shields.io/badge/Neovim-0.12+-green.svg)](https://neovim.io)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Startup](https://img.shields.io/badge/Startup-215ms-brightgreen.svg)](NEOVIM_SETUP_GUIDE.md)

Terminal-based IDE replacement optimized for:
- 📱 Android Development (Kotlin, Java)
- 🔄 Kotlin Multiplatform (KMP)
- 🍃 Spring Boot Backend
- 🌐 Web Development
- 🛠️ 20+ Programming Languages

---

## ✨ Features

### 🎯 Core Capabilities
- **Blazing Fast** - 215ms startup (75% faster than default)
- **20+ LSP Servers** - Full language support with autocomplete
- **Dual AI Assistants** - GitHub Copilot + Codeium (F9 to toggle)
- **Smart Project Detection** - Auto-configures for Android/Spring/Node/Rust
- **Advanced Git Integration** - Inline blame, conflict resolution, diff viewer
- **REST API Testing** - Test APIs directly from `.http` files
- **Multiple Terminals** - Dedicated terminals for Gradle/Maven + REPLs

### 📱 Android/KMP Development
```vim
:AndroidBuild          " Build APK
:AndroidInstall        " Install to device
:AndroidLogcat myapp   " Filtered logcat
:KmpBuild              " Build KMP shared module
```
- Device picker for multi-device testing
- ADB integration (shell, screenshot, uninstall)
- Kotlin LSP with performance tuning

### 🍃 Spring Boot Development
```vim
:SpringRun             " Run Spring Boot app
:SpringBuild           " Maven/Gradle auto-detected
:SpringProperties      " Quick access to configs
```
- Auto-detect Maven/Gradle projects
- Fast navigation: Controller → Service → Repository → Entity
- Test file auto-generation with templates

### 🔧 Smart Code Navigation
```vim
<leader>gf    " Jump to related files (Controller → Service → Repo)
<leader>gt    " Jump to test (creates if missing)
<leader>fc    " Find all Controllers
```
- Spring Boot: Controller/Service/Repository/Entity navigation
- Android: Activity/ViewModel/Fragment jumping
- Auto-create test files with proper templates

---

## 📸 Screenshots

### File Explorer & LSP
![File Explorer](https://via.placeholder.com/800x450?text=NvimTree+%2B+LSP+Autocomplete)

### Multi-Terminal Workflow
![Terminals](https://via.placeholder.com/800x450?text=Multiple+Terminals+%2B+REPLs)

### Git Integration
![Git](https://via.placeholder.com/800x450?text=Gitsigns+%2B+Diffview)

---

## 🚀 Quick Start

### Prerequisites
```bash
# Ubuntu/Debian
sudo apt install neovim ripgrep fd-find jq git curl

# Arch Linux
sudo pacman -S neovim ripgrep fd jq git curl

# macOS
brew install neovim ripgrep fd jq git curl
```

**Required versions:**
- Neovim 0.12+ (dev build recommended)
- Java 21+
- Gradle 8.5+ or Maven 3.8+
- Node.js 18+ (for some LSP servers)

### Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repo
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim

# First launch (auto-installs plugins)
nvim
```

Wait ~2-3 minutes for plugin installation.

### Post-Install

```vim
" Install LSP servers
:Mason

" Check health
:checkhealth

" View keybindings
:WhichKey
```

---

## 📖 Documentation

📘 **[Full Setup Guide](NEOVIM_SETUP_GUIDE.md)** - Complete documentation with:
- Detailed feature explanations
- All keybindings reference
- Troubleshooting guide
- Performance optimization tips

---

## ⌨️ Essential Keybindings

### Quick Reference

| Category | Key | Action |
|----------|-----|--------|
| **AI** | `F9` | Toggle Copilot ↔ Codeium |
| **AI** | `F10` | Disable/Enable AI |
| **File** | `<C-e>` | Toggle file tree |
| **File** | `<C-p>` | Find files |
| **File** | `<C-S-f>` | Search in files |
| **Android** | `<leader>ab` | Build Android |
| **Android** | `<leader>ai` | Install to device |
| **Android** | `<leader>al` | Logcat |
| **Spring** | `<leader>sr` | Run Spring Boot |
| **Spring** | `<leader>sb` | Build |
| **Spring** | `<leader>st` | Test |
| **Nav** | `<leader>gf` | Related files |
| **Nav** | `<leader>gt` | Jump to test |
| **Git** | `<leader>hs` | Stage hunk |
| **Git** | `<leader>tb` | Toggle blame |
| **Git** | `<leader>gd` | Diff view |
| **Term** | `<C-`>` | Toggle terminal |
| **Term** | `<leader>rk` | Kotlin REPL |
| **Build** | `<leader>bb` | Build project |
| **Build** | `<leader>bt` | Run tests |

> 💡 **Leader key is `<Space>`**

[See complete keybindings →](NEOVIM_SETUP_GUIDE.md#-complete-keybindings-reference)

---

## 🎓 Example Workflows

### Android Development
```bash
# Open Android project
cd ~/projects/my-android-app
nvim

# Build and install
:AndroidBuild
:AndroidInstall

# Watch logs
:AndroidLogcat MainActivity

# Jump between files
<leader>gf    # Activity → ViewModel → Fragment
```

### Spring Boot + REST API Testing
```bash
# Open Spring project
cd ~/projects/my-spring-api
nvim

# Run Spring Boot
:SpringRun

# Create API tests
:RestNew api.http
# Add your requests, press <CR> to test
```

### Multi-Project Workflow
```vim
<leader>pp    " Open project picker
              " Select: my-android-app
:AndroidBuild

<leader>pp    " Switch projects
              " Select: my-spring-backend
:SpringTest
```

---

## 🔧 What's Inside

### Optimizations Applied
- ✅ 75% faster startup (872ms → 215ms)
- ✅ LSP debounce tuning (150ms general, 300ms Kotlin)
- ✅ Treesitter optimized (disabled for large files)
- ✅ Lazy-loaded plugins
- ✅ Disabled unused Neovim built-ins

### 52 Plugins Installed
**Core:**
- lazy.nvim - Plugin manager
- nvim-lspconfig - LSP configuration
- nvim-treesitter - Syntax highlighting
- nvim-cmp - Autocompletion
- telescope.nvim - Fuzzy finder

**Development:**
- copilot.lua + codeium.nvim - AI pair programming
- conform.nvim - Auto-formatting
- trouble.nvim - Better diagnostics
- gitsigns.nvim - Git integration
- toggleterm.nvim - Terminal management

**Custom Plugins (8 new):**
1. `android.lua` - Android/KMP commands
2. `spring-boot.lua` - Spring Boot helpers
3. `rest-client.lua` - API testing
4. `project-manager.lua` - Project switching
5. `code-navigation.lua` - Smart file jumping
6. `git-enhanced.lua` - Advanced Git features
7. `terminal-enhanced.lua` - Multi-terminal + REPLs
8. `build-automation.lua` - Universal build commands

[View complete plugin list →](NEOVIM_SETUP_GUIDE.md#file-structure)

---

## 🎯 Supported Languages

### With Full LSP Support
- ✅ Kotlin (kotlin_language_server)
- ✅ Java (jdtls)
- ✅ TypeScript/JavaScript (ts_ls)
- ✅ Python (pyright)
- ✅ Lua (lua_ls)
- ✅ Rust (rust_analyzer)
- ✅ Go (gopls)
- ✅ C/C++ (clangd)
- ✅ HTML/CSS (html, cssls)
- ✅ And 11 more...

### With Syntax Highlighting (Treesitter)
Over 40 languages including:
- Kotlin, Java, Swift
- JavaScript, TypeScript, TSX
- Python, Lua, Rust, Go
- HTML, CSS, SCSS, JSON, YAML
- Markdown, SQL, GraphQL
- Dockerfile, Bash, and more

---

## 🐛 Troubleshooting

### Common Issues

**LSP not working:**
```vim
:LspInfo          " Check server status
:Mason            " Reinstall servers
:checkhealth lsp
```

**Slow startup:**
```vim
:Lazy profile     " Find slow plugins
```

**AI not responding:**
```vim
:Copilot status   " Check Copilot
F9                " Toggle to Codeium
```

**Formatter errors:**
```vim
:ConformInfo      " Check formatter status
:Mason            " Install missing formatters
```

[More troubleshooting →](NEOVIM_SETUP_GUIDE.md#-troubleshooting)

---

## 📊 Performance

### Benchmarks
| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Startup Time | 872ms | 215ms | **75% faster** |
| Plugin Load | 838ms | 178ms | **79% faster** |
| Memory (idle) | ~45MB | ~35MB | **22% less** |

Tested on:
- System: Pop!_OS 24.04
- CPU: AMD/Intel x86_64
- RAM: 16GB
- Neovim: 0.12.0-dev

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly (`:checkhealth`)
5. Submit a pull request

### Reporting Issues
- Check existing issues first
- Include `:checkhealth` output
- Provide minimal reproduction steps
- Mention your OS and Neovim version

---

## 📜 License

MIT License - Feel free to use and modify!

---

## 🙏 Acknowledgments

Built with these amazing plugins:
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin management
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finding
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Terminals
- And 47 other fantastic plugins!

---

## 📞 Support

- 📖 [Full Documentation](NEOVIM_SETUP_GUIDE.md)
- 🐛 [Issue Tracker](https://github.com/YOUR_USERNAME/nvim-config/issues)
- 💬 [Discussions](https://github.com/YOUR_USERNAME/nvim-config/discussions)

---

**Star ⭐ this repo if you find it useful!**

Made with ❤️ for mobile and backend developers
