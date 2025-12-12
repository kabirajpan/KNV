# ✨ KNV

**Kabiraj's Neovim Configuration**

A modern, modular, and blazing fast Neovim setup powered by **Lazy.nvim**.  
Designed to be **modular, fast, and developer-friendly**, with features for **coding, Git, UI enhancements, and productivity**.

> 🎉 **Optimized for Pop OS 24.04 Cosmic Desktop** (Released December 11, 2025)

---

## 📂 Project Structure

```
.
├── init.lua                  # Entry point
├── keymaps.lua              # Global keymaps (VS Code-style bindings)
├── lazy-lock.json           # Plugin version lockfile
└── lua
    ├── core                 # Core configuration
    │   ├── autocmds.lua
    │   ├── commands.lua
    │   ├── duplicate_window_fix.lua
    │   ├── init.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   ├── options.lua
    │   └── ui.lua
    ├── plugins              # Plugin configs (45 plugins)
    │   ├── android.lua      # Android development support
    │   ├── autopairs.lua    # Auto-close brackets
    │   ├── autotag.lua      # Auto-close HTML tags
    │   ├── barbecue.lua     # Breadcrumb navigation
    │   ├── bufferline.lua   # Buffer/tab line
    │   ├── cmp.lua          # Autocompletion
    │   ├── codeium.lua      # AI code completion
    │   ├── comment.lua      # Comment toggle
    │   ├── conform.lua      # Code formatting
    │   ├── copilot.lua      # GitHub Copilot
    │   ├── dashboard.lua    # Start screen
    │   ├── diffview.lua     # Git diff viewer
    │   ├── fugitive.lua     # Git integration
    │   ├── gitsigns.lua     # Git signs in gutter
    │   ├── gruvbox.lua      # Gruvbox theme
    │   ├── indentline.lua   # Indent guides
    │   ├── lazygit.lua      # LazyGit UI
    │   ├── lsp.lua          # LSP configuration
    │   ├── lualine.lua      # Status line
    │   ├── notify.lua       # Notifications
    │   ├── nvimtree.lua     # File explorer
    │   ├── persisted.lua    # Session management
    │   ├── project.lua      # Project management
    │   ├── snippets.lua     # Code snippets
    │   ├── surround.lua     # Surround text objects
    │   ├── telescope.lua    # Fuzzy finder
    │   ├── telescope-fzf-native.lua
    │   ├── toggleterm.lua   # Terminal toggle
    │   ├── treesitter.lua   # Syntax highlighting
    │   ├── web-devicons.lua # File icons
    │   └── whichkey.lua     # Keybinding helper
    └── snippets             # Custom snippets
        ├── html.lua
        └── react.lua
```

---

## ✨ Features

### 🚀 Core Features

- ⚡ **Lazy.nvim** – Modern plugin manager with lazy loading
- 🎨 **Gruvbox Theme** – Beautiful dark colorscheme
- 🖥️ **VS Code-style Keybindings** – Familiar shortcuts (Ctrl+C/V/Z, etc.)
- 🔄 **Wayland Clipboard Support** – Works perfectly with Pop OS Cosmic
- 📦 **45+ Plugins** – Carefully curated for productivity

### 🎨 UI Enhancements

- **Lualine** – Beautiful statusline with AI integration indicators
- **Bufferline** – Tab-like buffer management
- **Dashboard** – Custom start screen
- **Notify** – Beautiful notifications
- **Barbecue** – Breadcrumb navigation
- **Indent Guides** – Visual indentation lines

### 🔍 Navigation & Search

- **Telescope** – Fuzzy finder for files, grep, buffers
- **Nvim-tree** – File explorer with mouse support
- **Project.nvim** – Automatic project detection
- **Which-key** – Interactive keybinding guide

### 🧠 Code Intelligence

- **LSP Support** – 20+ language servers configured:
  - TypeScript/JavaScript (ts_ls)
  - Python (pyright)
  - Rust (rust-analyzer)
  - Java (jdtls)
  - C/C++ (clangd)
  - HTML/CSS (html, cssls)
  - And many more...
- **Treesitter** – Advanced syntax highlighting
- **Autocompletion** – nvim-cmp with multiple sources
- **Code Formatting** – conform.nvim with prettier, stylua

### 🤖 AI Integration

- **GitHub Copilot** – AI pair programming
- **Codeium** – Free AI code completion
- **F9** – Toggle between Copilot ↔ Codeium
- **F10** – Enable/Disable all AI

### 🔄 Git Integration

- **Fugitive** – Full Git workflow
- **LazyGit** – Beautiful Git UI
- **Gitsigns** – Git changes in gutter
- **Diffview** – Advanced diff viewer

### 📝 Productivity Tools

- **Autopairs** – Auto-close brackets
- **Autotag** – Auto-close HTML/JSX tags
- **Comment.nvim** – Toggle comments (Ctrl+/)
- **Surround** – Manipulate surrounding characters
- **ToggleTerm** – Integrated terminal
- **Session Management** – Auto-save/restore sessions

### 📱 Android Development

- **Android.nvim** – Android project support
- Gradle integration
- Logcat viewer

---

## ⚙️ Installation

### 1. Prerequisites

<details>
<summary><b>🐧 Linux (Ubuntu/Pop OS/Debian)</b></summary>

**Required:**

```bash
# Neovim 0.11+ (or nightly)
nvim --version

# Git
sudo apt install git

# Clipboard support
# For Wayland (Pop OS Cosmic, GNOME on Wayland)
sudo apt install wl-clipboard

# For X11
sudo apt install xclip
# or
sudo apt install xsel

# Node.js & npm (for Copilot/Codeium)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs

# Build tools (for Treesitter)
sudo apt install build-essential
```

**Recommended:**

```bash
# Ripgrep (for Telescope live grep)
sudo apt install ripgrep

# fd (for Telescope file finder)
sudo apt install fd-find

# A Nerd Font (for icons)
# Download from: https://www.nerdfonts.com/
# Recommended: JetBrainsMono Nerd Font, FiraCode Nerd Font
```

**Optional Language Tools:**

```bash
# Python support
pip install --user --break-system-packages pynvim
# or on older systems
pip install --user pynvim

# Node.js neovim package
npm install -g neovim

# Formatters
npm install -g prettier
cargo install stylua
sudo apt install black shfmt
```

</details>

<details>
<summary><b>🍎 macOS</b></summary>

**Required:**

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Neovim
brew install neovim

# Git (usually pre-installed)
brew install git

# Node.js & npm
brew install node

# Build tools (Xcode Command Line Tools)
xcode-select --install
```

**Recommended:**

```bash
# Ripgrep
brew install ripgrep

# fd
brew install fd

# A Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

**Optional Language Tools:**

```bash
# Python support
pip3 install pynvim

# Node.js neovim package
npm install -g neovim

# Formatters
npm install -g prettier
cargo install stylua
brew install black shfmt
```

</details>

<details>
<summary><b>🪟 Windows (WSL2 Recommended)</b></summary>

**Option 1: WSL2 (Recommended)**

```bash
# Install WSL2 with Ubuntu
wsl --install

# Then follow the Linux (Ubuntu) instructions above
```

**Option 2: Native Windows**

```powershell
# Install using Scoop
scoop install neovim git

# Or using Chocolatey
choco install neovim git

# Install Node.js
# Download from: https://nodejs.org/

# Install Build Tools
# Download Visual Studio Build Tools from Microsoft

# Clipboard should work natively on Windows
```

**Recommended (Windows):**

```powershell
# Using Scoop
scoop install ripgrep fd

# Or using Chocolatey
choco install ripgrep fd

# Install a Nerd Font manually from:
# https://www.nerdfonts.com/
```

**Optional Language Tools (Windows):**

```powershell
# Python support
pip install pynvim

# Node.js neovim package
npm install -g neovim

# Formatters
npm install -g prettier
cargo install stylua
```

</details>

<details>
<summary><b>🎩 Arch Linux</b></summary>

**Required:**

```bash
# Neovim
sudo pacman -S neovim

# Git
sudo pacman -S git

# Clipboard support
# For Wayland
sudo pacman -S wl-clipboard

# For X11
sudo pacman -S xclip

# Node.js & npm
sudo pacman -S nodejs npm

# Build tools
sudo pacman -S base-devel
```

**Recommended:**

```bash
# Ripgrep & fd
sudo pacman -S ripgrep fd

# Nerd Fonts
sudo pacman -S ttf-jetbrains-mono-nerd
```

**Optional Language Tools:**

```bash
# Python support
pip install --user pynvim

# Node.js neovim package
npm install -g neovim

# Formatters
npm install -g prettier
cargo install stylua
sudo pacman -S python-black shfmt
```

</details>

<details>
<summary><b>🎩 Fedora/RHEL/CentOS</b></summary>

**Required:**

```bash
# Neovim
sudo dnf install neovim

# Git
sudo dnf install git

# Clipboard support
# For Wayland
sudo dnf install wl-clipboard

# For X11
sudo dnf install xclip

# Node.js & npm
sudo dnf install nodejs npm

# Build tools
sudo dnf groupinstall "Development Tools"
```

**Recommended:**

```bash
# Ripgrep & fd
sudo dnf install ripgrep fd-find
```

**Optional Language Tools:**

```bash
# Python support
pip install --user pynvim

# Node.js neovim package
npm install -g neovim

# Formatters
npm install -g prettier
cargo install stylua
```

</details>

### 2. Clone the Config

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak

# Clone KNV
git clone https://github.com/kabirajpan/KNV.git ~/.config/nvim

# Open Neovim - plugins will auto-install
nvim
```

### 3. Post-Installation

```bash
# Check health
:checkhealth

# Authenticate Copilot (optional)
:Copilot auth

# Install language servers via Mason
:Mason
```

---

## 🎹 Keybindings

### 🖱️ VS Code-Style Shortcuts

| Shortcut | Mode          | Action                                 |
| -------- | ------------- | -------------------------------------- |
| `Ctrl+S` | All           | Save file                              |
| `Ctrl+C` | Visual/Normal | Copy                                   |
| `Ctrl+X` | Visual/Normal | Cut                                    |
| `Ctrl+V` | All           | Paste (works from external clipboard!) |
| `Ctrl+Z` | All           | Undo                                   |
| `Ctrl+Y` | All           | Redo                                   |
| `Ctrl+A` | All           | Select all                             |
| `Ctrl+F` | Normal        | Find/search                            |
| `Ctrl+H` | Normal        | Find and replace                       |
| `Ctrl+/` | All           | Toggle comment                         |
| `Ctrl+W` | Normal        | Close buffer                           |
| `Ctrl+Q` | Normal        | Quit                                   |

### 🔍 Navigation

| Shortcut               | Action                      |
| ---------------------- | --------------------------- |
| `Ctrl+E`               | Toggle file explorer        |
| `Ctrl+P`               | Find files (Telescope)      |
| `Ctrl+Shift+F`         | Live grep (search in files) |
| `Ctrl+B`               | Buffer list                 |
| `Ctrl+1-9`             | Jump to buffer 1-9          |
| `Alt+Left/Right`       | Previous/Next buffer        |
| `Alt+Shift+Left/Right` | Move buffer left/right      |

### ✏️ Editing

| Shortcut            | Action                 |
| ------------------- | ---------------------- |
| `Alt+Up/Down`       | Move line up/down      |
| `Alt+Shift+Up/Down` | Duplicate line up/down |
| `Ctrl+Shift+K`      | Delete line            |
| `Tab`               | Indent (visual mode)   |
| `Shift+Tab`         | Unindent               |
| `Ctrl+Backspace`    | Delete word left       |
| `Ctrl+Delete`       | Delete word right      |

### 🤖 AI Commands

| Shortcut    | Action                      |
| ----------- | --------------------------- |
| `F9`        | Toggle Copilot ↔ Codeium    |
| `F10`       | Enable/Disable all AI       |
| `Alt+Enter` | Accept Codeium suggestion   |
| `Alt+]`     | Next Codeium suggestion     |
| `Alt+[`     | Previous Codeium suggestion |

### 🔤 LSP (Code Intelligence)

| Shortcut      | Action              |
| ------------- | ------------------- |
| `gd` or `F12` | Go to definition    |
| `F2`          | Rename symbol       |
| `K`           | Hover documentation |
| `Ctrl+.`      | Code actions        |
| `Shift+F12`   | Find references     |

### 📂 Leader Key Shortcuts

**Leader = `Space`**

| Shortcut     | Action                |
| ------------ | --------------------- |
| `<leader>ff` | Find files            |
| `<leader>fg` | Live grep             |
| `<leader>fb` | Browse buffers        |
| `<leader>fh` | Help tags             |
| `<leader>e`  | File explorer         |
| `<leader>gs` | Git status (Fugitive) |
| `<leader>lg` | LazyGit UI            |
| `<leader>ut` | Theme switcher        |

### 💻 Terminal

| Shortcut | Action             |
| -------- | ------------------ |
| `Ctrl+`` | Toggle terminal    |
| `Esc`    | Exit terminal mode |

---

## 🛠️ Customization

### Adding New Plugins

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/myplugin.lua
return {
  "author/plugin-name",
  config = function()
    -- plugin config here
  end,
}
```

### Changing Theme

Edit `lua/plugins/gruvbox.lua` or add a new theme plugin.

### Modifying Keybindings

Edit:

- `lua/core/keymaps.lua` - Core keymaps
- `keymaps.lua` (root) - VS Code-style keymaps

### LSP Configuration

Edit `lua/plugins/lsp.lua` to add/remove language servers.

### Formatter Configuration

Edit `lua/plugins/conform.lua` to customize formatters.

---

## 🐛 Troubleshooting

<details>
<summary><b>🐧 Linux Issues</b></summary>

**Clipboard not working**

```bash
# For Wayland (Pop OS Cosmic, GNOME)
sudo apt install wl-clipboard

# For X11
sudo apt install xclip
# or
sudo apt install xsel

# Check if it's working
:checkhealth
```

**Plugins not loading**

```bash
# Remove lazy-lock.json and reinstall
rm ~/.config/nvim/lazy-lock.json
nvim
:Lazy sync
```

**LSP not working**

```bash
# Install language servers via Mason
:Mason
# Then install the servers you need
```

**Codeium error**

```bash
# Clear cache and restart
rm -rf ~/.cache/nvim/codeium
nvim
```

**Permission errors with pip**

```bash
# Use --break-system-packages flag (Ubuntu 24.04+)
pip install --user --break-system-packages pynvim
```

</details>

<details>
<summary><b>🍎 macOS Issues</b></summary>

**Clipboard not working**

```bash
# macOS clipboard should work out of the box
# If not, check permissions in System Settings > Privacy & Security
```

**Treesitter compile errors**

```bash
# Install Xcode Command Line Tools
xcode-select --install
```

**Python provider issues**

```bash
# Make sure Python 3 is default
python3 --version
pip3 install pynvim
```

**Node.js issues**

```bash
# Update Node.js via Homebrew
brew upgrade node
npm install -g neovim
```

</details>

<details>
<summary><b>🪟 Windows Issues</b></summary>

**Use WSL2 for best experience**

```bash
# Install WSL2 if not already
wsl --install
# Then follow Linux instructions
```

**Native Windows clipboard**

```powershell
# Should work out of the box
# If not, try running Neovim as administrator
```

**Build tool errors**

```powershell
# Install Visual Studio Build Tools
# Download from Microsoft's website
```

**Path issues**

```powershell
# Make sure these are in PATH:
# - Neovim
# - Git
# - Node.js
# Check with: $env:PATH
```

</details>

<details>
<summary><b>🌐 General Issues</b></summary>

**Neovim version too old**

```bash
# Check version
nvim --version

# Upgrade to 0.11+
# Linux: Use AppImage or build from source
# macOS: brew upgrade neovim
# Windows: scoop update neovim
```

**Plugins not syncing**

```bash
# Force sync all plugins
:Lazy sync

# Update all plugins
:Lazy update

# Clean unused plugins
:Lazy clean
```

**Slow startup**

```bash
# Profile startup time
nvim --startuptime startup.log

# Check which plugins are slow
:Lazy profile
```

**Icons not showing**

```bash
# Install a Nerd Font
# https://www.nerdfonts.com/
# Then configure your terminal to use it
```

</details>

---

## 📊 Tested On

- ✅ **Pop OS 24.04 LTS (Cosmic Desktop)** - Released December 11, 2025
- ✅ **Ubuntu 24.04 LTS / 22.04 LTS**
- ✅ **Arch Linux**
- ✅ **Fedora 39+**
- ✅ **macOS 13+ (Ventura, Sonoma, Sequoia)**
- ✅ **Windows 11 (via WSL2)**
- ✅ **Neovim 0.11+**
- ✅ **Wayland + X11**

---

## 🙏 Credits

Built with these amazing projects:

- [Neovim](https://neovim.io/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Gruvbox](https://github.com/morhetz/gruvbox)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- And 40+ other amazing plugins!

---

## 📜 License

MIT License - Free to use and modify.

---

## 👨‍💻 Author

**Kabiraj Pan**

- 🌐 Portfolio: [kabirajpan.is-a.dev](https://kabirajpan.is-a.dev)
- 🔗 GitHub: [@kabirajpan](https://github.com/kabirajpan)
- 📧 Email: [kabirajpan2@gmail.com](mailto:kabirajpan2@gmail.com)
- 💼 LinkedIn: [Kabiraj Pan](https://linkedin.com/in/kabirajpan)

---

## ⭐ Star History

If you find this config useful, please consider giving it a star! ⭐

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

**Made with ❤️ for the Neovim community**
