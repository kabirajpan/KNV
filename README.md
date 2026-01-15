# 🎯 KNV - Kabiraj's Neovim Configuration

**A modern, modular, blazing-fast Neovim setup** powered by **Lazy.nvim**  
Designed for **cross-platform compatibility** (Windows, Linux, macOS) with features for **coding, Git, UI enhancements, and productivity**.

> ✨ **Latest Update:** Full cross-platform support (Windows, Linux, macOS)  
> 🚀 **Status:** Production-ready with 45+ plugins  
> 🎨 **Theme:** Gruvbox with transparency support

---

## 📋 Table of Contents

- [Features](#-features)
- [Platform Support](#-platform-support)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Keymaps](#-keymaps)
- [Plugins](#-plugins)
- [Troubleshooting](#-troubleshooting)
- [Project Structure](#-project-structure)

---

## ✨ Features

### 🔥 Core Features
- **Fast startup** with lazy-loaded plugins (~100ms)
- **80+ intelligent keymaps** (VS Code compatible)
- **Full cross-platform support** (Windows, Linux, macOS)
- **Automatic LSP setup** with Mason
- **AI-powered coding** (Copilot + Codeium)
- **Git integration** (Fugitive, Gitsigns, LazyGit)
- **Terminal multiplexing** with Toggleterm
- **REST API testing** with rest.nvim
- **Project auto-detection** (Android, Spring Boot, Node, Rust, etc.)

### 🎨 UI/UX
- **Gruvbox theme** with transparent background
- **Lualine** status bar with real-time AI status
- **Bufferline** for elegant tab management
- **NvimTree** file explorer with Nerd Font icons
- **Barbecue** breadcrumb navigation
- **Telescope** fuzzy finder with FZF Native
- **Notifications** system with nvim-notify
- **Dashboard** startup screen

### 🛠️ Developer Tools
- **LSP** for 30+ languages (auto-installed)
- **Treesitter** for precise syntax highlighting
- **Auto-formatting** with Conform
- **Git integration** with signs in gutter
- **Terminal REPLs** (Python, Node, Kotlin)
- **Build automation** (Gradle, Maven, Cargo, npm)
- **Code snippets** with LuaSnip
- **Smart comments** with Comment.nvim

### 🚀 Advanced Features
- **Toggle Copilot ↔ Codeium** (F9)
- **Enable/Disable all AI** (F10)
- **Spring Boot helpers** with quick run/build
- **Android development** with APK build/install
- **REST client** for API testing
- **Diff viewer** for git comparisons
- **Trouble** diagnostics viewer
- **Which-key** keybinding help

---

## 🌍 Platform Support

All features work across platforms. Platform-specific issues are automatically handled:

| Feature | Linux | macOS | Windows |
|---------|-------|-------|---------|
| **Keymaps** | ✅ | ✅ | ✅ |
| **Terminal** | ✅ | ✅ | ✅ |
| **LSP/Mason** | ✅ | ✅ | ✅ |
| **Git** | ✅ | ✅ | ✅ |
| **Copilot** | ✅ | ✅ | ✅ |
| **Codeium** | ✅ | ✅ | ✅ |
| **Build Tools** | ✅ | ✅ | ✅ (auto-detects .bat) |
| **Spring Boot** | ✅ | ✅ | ✅ |
| **Android Dev** | ✅ | ✅ | ✅ |

---

## 🚀 Quick Start

### Prerequisites

```bash
# Ubuntu/Debian
sudo apt-get install -y neovim git curl

# macOS
brew install neovim git curl

# Windows (PowerShell)
winget install Neovim Git
```

### Installation (3 steps)

```bash
# 1. Clone configuration
git clone https://github.com/yourusername/nvim ~/.config/nvim
cd ~/.config/nvim

# 2. Launch Neovim
nvim

# 3. Wait for plugins to install (auto-installs on first launch)
# Then restart Neovim
```

### First Run Setup

```vim
" Setup GitHub Copilot (optional)
:Copilot auth

" Install a language server
:MasonInstall lua-language-server

" Check health
:checkhealth
```

---

## 📦 Installation Guide

### Linux & macOS (Recommended)

```bash
# Clone repository
git clone https://github.com/yourusername/nvim ~/.config/nvim

# Install dependencies (Ubuntu/Debian)
sudo apt-get install -y \
  build-essential \
  cmake \
  python3-dev \
  curl \
  git

# Install dependencies (macOS)
brew install cmake python3 curl

# Launch and auto-install plugins
nvim
```

### Windows (PowerShell)

```powershell
# Clone repository
git clone https://github.com/yourusername/nvim $env:APPDATA/Local/nvim
cd $env:APPDATA/Local/nvim

# Install dependencies (Scoop)
scoop install cmake nodejs python git

# Or using winget
winget install Python.Python.3.11
winget install Node.js
winget install Git.Git

# Launch
nvim
```

### Install Nerd Font (Required for Icons!)

**Without a Nerd Font, you'll see empty boxes instead of icons.**

#### Linux
```bash
# Download font from https://www.nerdfonts.com
# Example: JetBrains Mono Nerd

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
unzip ~/Downloads/JetBrainsMonoNerd.zip
fc-cache -fv

# Verify installation
fc-list | grep "Nerd Font"
```

#### macOS
```bash
# Using Homebrew
brew install --cask font-jetbrains-mono-nerd-font

# Or manually download from https://www.nerdfonts.com
```

#### Windows
1. Download font from https://www.nerdfonts.com
2. Right-click the `.ttf` file
3. Select "Install"
4. Set in your terminal emulator settings

**Recommended fonts:**
- JetBrains Mono Nerd Font ⭐ (best)
- FiraCode Nerd Font
- Hack Nerd Font
- Fira Mono Nerd Font

---

## ⚙️ Configuration

### Core Settings

Edit `lua/core/options.lua`:
```lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
```

### Keymaps

Edit `lua/core/keymaps.lua` to customize keybindings

### Plugins

Enable/disable in `lua/plugins/` by editing files:
```lua
-- Disable: return {}
-- Enable: return { "plugin/name", config = function() ... end }
```

### Theme

Edit `lua/plugins/gruvbox.lua`:
```lua
require("gruvbox").setup({
  transparent = true,  -- or false
})
```

### Terminal Shell (Windows)

Edit `lua/core/options.lua`:
```lua
-- PowerShell
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-Command"

-- Or Git Bash
vim.opt.shell = "bash"
vim.opt.shellcmdflag = "-c"
```

---

## 🎮 Essential Keymaps

### Mode Switching
```
<Esc> / jk     → Exit to Normal mode
i / a          → Insert mode
v / V / <C-v>  → Visual mode
```

### Clipboard (VS Code style)
```
<C-c>       → Copy
<C-x>       → Cut
<C-v>       → Paste
<C-z>       → Undo
<C-y>       → Redo
<C-s>       → Save
```

### Navigation & Selection
```
<Home> / <End>          → Line start/end
<C-Left> / <C-Right>    → Word navigation
<S-Arrow>               → Character selection
<C-S-Arrow>             → Word selection
<S-Home> / <S-End>      → Line selection
<C-a>                   → Select All
```

### File & Buffer Management
```
<C-e>                   → Toggle file explorer
<A-Left> / <A-Right>    → Previous/Next buffer
<leader>h / <leader>l>  → Buffer nav (fallback)
<C-n>                   → New buffer
<C-w>                   → Close buffer
<C-Tab> / <C-S-Tab>     → Buffer switching
```

### Code Editing
```
<A-Up> / <A-Down>       → Move lines
<A-S-Up> / <A-S-Down>   → Duplicate lines
<C-S-k>                 → Delete line
<Tab> / <S-Tab>         → Indent/Unindent
<C-/>                   → Toggle comment
<C-_>                   → Comment (fallback)
<C-.>                   → Code action
```

### Search & Replace
```
<C-f>       → Find (/)
<C-h>       → Find & Replace (:%s/)
<F3>        → Next match
<S-F3>      → Previous match
```

### Terminal & REPL
```
<C-`>           → Toggle terminal
<leader>t1/t2   → Terminal 1/2
<leader>tf      → Floating terminal
<leader>rp      → Python REPL
<leader>rn      → Node REPL
<leader>rk      → Kotlin REPL
```

### LSP & Diagnostics
```
<F12> / gd      → Go to definition
<F2>            → Rename symbol
<S-F12>         → Find references
K               → Hover documentation
<leader>xx      → Toggle diagnostics
```

### Git
```
<leader>gs      → Git status
<leader>lg      → LazyGit (best!)
```

### AI Tools
```
<F9>            → Toggle Copilot ↔ Codeium
<F10>           → Enable/Disable AI
<C-j>           → Accept Copilot
```

### Telescope
```
<C-p>           → Find files
<C-S-f>         → Live grep
<leader>ff      → Find files
<leader>fg      → Live grep
<leader>fb      → Buffers
```

### Quick Actions
```
<C-q>           → Quit Neovim
<C-S-q>         → Quit all
```

---

## 📦 Plugins (45+)

### Essential
- **lazy.nvim** - Plugin manager
- **plenary.nvim** - Common utilities

### LSP & Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP/formatter installer
- **nvim-cmp** - Autocompletion engine
- **LuaSnip** - Snippet engine
- **copilot.lua** - GitHub Copilot
- **codeium.nvim** - Codeium AI

### UI
- **gruvbox.nvim** - Theme
- **lualine.nvim** - Status bar
- **bufferline.nvim** - Tab bar
- **nvim-tree.lua** - File explorer
- **barbecue.nvim** - Breadcrumb
- **nvim-web-devicons** - File icons
- **nvim-notify** - Notifications
- **dashboard-nvim** - Start screen

### Syntax & Navigation
- **nvim-treesitter** - Syntax highlighting
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - FZF extension

### Git Integration
- **vim-fugitive** - Git commands
- **gitsigns.nvim** - Git signs
- **diffview.nvim** - Diff viewer
- **lazygit.nvim** - LazyGit UI

### Editing Tools
- **comment.nvim** - Comment toggling
- **nvim-autopairs** - Auto pair brackets
- **nvim-autotag** - Auto close HTML tags
- **vim-surround** - Surround operations
- **toggleterm.nvim** - Terminal
- **conform.nvim** - Formatter

### Utilities
- **indent-blankline.nvim** - Indent guides
- **trouble.nvim** - Diagnostics viewer
- **fidget.nvim** - LSP progress
- **which-key.nvim** - Keybinding help
- **rest.nvim** - REST client
- **project.nvim** - Project detection
- **persisted.nvim** - Session persistence

### Language-specific
- **kotlin-vim** - Kotlin support
- **vim-gradle** - Gradle support
- **xml.vim** - XML support
- Spring Boot helpers
- Android development helpers

---

## 🆘 Troubleshooting

### Icons Not Displaying

**Problem:** Square boxes or missing icons

**Solution:**
```bash
# 1. Install Nerd Font (see installation section)
# 2. Set it in your terminal settings
# 3. Verify:
:checkhealth nvim-web-devicons
```

### Copilot Issues

```vim
" Re-authenticate
:Copilot auth

" Check status
:Copilot status

" Enable/Disable
:Copilot enable
:Copilot disable
```

### LSP Not Working

```vim
" Check LSP status
:LspInfo

" Install language server
:MasonInstall lua-language-server

" View Mason UI
:Mason
```

### Slow Startup

```vim
" Check startup time
:StartupTime

" Disable unused plugins in lua/plugins/
" Remove or comment out plugin configs
```

### Terminal Not Working (Windows)

Edit `lua/core/options.lua`:
```lua
-- Use PowerShell
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-Command"

-- Or use Git Bash
vim.opt.shell = "bash"
```

### Alt Key Combinations Not Working

**Already fixed with fallbacks:**
- Use `<leader>h` / `<leader>l` for buffer navigation
- Use `<C-_>` as fallback for comment toggle

---

## 📁 Project Structure

```
.config/nvim/
├── init.lua                          # Entry point
├── lazy-lock.json                    # Plugin lock file
├── lua/
│   ├── core/                         # Core configuration
│   │   ├── autocmds.lua              # Auto commands
│   │   ├── commands.lua              # Custom commands
│   │   ├── keymaps.lua               # 80+ keybindings
│   │   ├── lazy.lua                  # Lazy.nvim setup
│   │   ├── options.lua               # Vim options
│   │   └── init.lua                  # Load modules
│   │
│   ├── plugins/                      # Plugin configs (45+)
│   │   ├── android.lua               # Android dev
│   │   ├── autopairs.lua             # Auto brackets
│   │   ├── autotag.lua               # Auto HTML tags
│   │   ├── barbecue.lua              # Breadcrumb
│   │   ├── bufferline.lua            # Tab bar
│   │   ├── build-automation.lua      # Build commands
│   │   ├── cmp.lua                   # Completion
│   │   ├── codeium.lua               # Codeium AI
│   │   ├── comment.lua               # Comment toggle
│   │   ├── conform.lua               # Formatter
│   │   ├── copilot.lua               # GitHub Copilot
│   │   ├── dashboard.lua             # Start screen
│   │   ├── diffview.lua              # Diff viewer
│   │   ├── fugitive.lua              # Git
│   │   ├── gitsigns.lua              # Git signs
│   │   ├── gruvbox.lua               # Theme
│   │   ├── indentline.lua            # Indent guides
│   │   ├── lazygit.lua               # LazyGit UI
│   │   ├── lsp.lua                   # LSP config
│   │   ├── lualine.lua               # Status bar
│   │   ├── notify.lua                # Notifications
│   │   ├── nvimtree.lua              # File explorer
│   │   ├── persisted.lua             # Session save
│   │   ├── project-manager.lua       # Project detect
│   │   ├── project.lua               # Projects
│   │   ├── rest-client.lua           # REST client
│   │   ├── snippets.lua              # Snippets
│   │   ├── spring-boot.lua           # Spring Boot
│   │   ├── surround.lua              # Surround
│   │   ├── telescope.lua             # Fuzzy finder
│   │   ├── telescope-fzf-native.lua  # FZF native
│   │   ├── terminal-enhanced.lua     # Terminal
│   │   ├── toggleterm.lua            # Terminal UI
│   │   ├── treesitter.lua            # Syntax highlight
│   │   ├── web-devicons.lua          # File icons
│   │   └── whichkey.lua              # Help menu
│   │
│   └── snippets/                     # Custom snippets
│       ├── html.lua
│       └── react.lua
│
└── README.md                         # This file
```

---

## 🎓 Usage Examples

### Finding Files
```vim
<C-p>              " Quick file search
<C-S-f>            " Search text content
<leader>ff         " Find files (telescope)
<leader>fg         " Live grep (telescope)
```

### Git Workflow
```vim
<leader>gs         " Git status
<leader>lg         " LazyGit (interactive)
:Git log           " View history
:Git commit        " Commit changes
:Git push          " Push to remote
```

### Building Projects
```vim
:Build             " Auto-detect build system
:Test              " Run tests
:SpringRun         " Spring Boot app
:AndroidBuild      " Android APK
```

### Interactive Development
```vim
<leader>rp         " Python prompt
<leader>rn         " Node prompt
<leader>rk         " Kotlin prompt
```

### Code Navigation
```vim
gd                 " Go to definition
<F2>               " Rename
K                  " Documentation
<C-.>              " Code action
```

---

## ✅ Checklist After Installation

- [ ] Installed Nerd Font and set in terminal
- [ ] Ran `:Copilot auth` (if using Copilot)
- [ ] Ran `:MasonInstall` for language servers
- [ ] Checked `:checkhealth` (should be mostly green)
- [ ] Tested keymaps with `:WhichKey`
- [ ] Configured LSP for your language
- [ ] Set up your build system (Spring Boot, Gradle, etc.)

---

## 🚀 Performance

**Startup time:** ~100-200ms  
**Plugin count:** 45+  
**Lines of config:** ~3000+  
**Memory usage:** ~50-100MB

All plugins are lazy-loaded to maintain fast startup time.

---

## 📚 Learning Resources

- [Neovim Docs](https://neovim.io/doc)
- [Vim Tips](https://vim.fandom.com)
- [Lua Guide](https://www.lua.org/pil)
- [LSP Setup](https://github.com/neovim/nvim-lspconfig/wiki)

---

## 🤝 Contributing

Contributions welcome! Feel free to:
- Report bugs
- Suggest features
- Submit PRs
- Share configs

---

## 📄 License

MIT License - Use freely and modify as needed

---

## 🙏 Credits

Built with these amazing projects:
- [Neovim](https://neovim.io)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- And 40+ more amazing plugins!

---

**Happy coding! 🚀 Enjoy your blazing-fast Neovim setup!**
