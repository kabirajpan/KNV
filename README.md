# ✨ KNV

**Kabiraj’s Neovim Configuration**

A modern, modular, and blazing fast Neovim setup powered by **Lazy.nvim**.
Designed to be **modular, fast, and developer-friendly**, with features for **coding, Git, UI enhancements, and productivity**.

---

## 📂 Project Structure

```
.
├── init.lua                  # Entry point
├── lazy-lock.json            # Plugin version lockfile
└── lua
    ├── core                  # Core configuration
    │   ├── autocmds.lua
    │   ├── commands.lua
    │   ├── duplicate_window_fix.lua
    │   ├── init.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   ├── options.lua
    │   └── ui.lua
    ├── plugins               # Plugin configs
    │   ├── android.lua
    │   ├── autopairs.lua
    │   ├── autotag.lua
    │   ├── barbecue.lua
    │   ├── bufferline.lua
    │   ├── cmp.lua
    │   ├── codeium.lua
    │   ├── comment.lua
    │   ├── conform.lua
    │   ├── copilot.lua
    │   ├── dashboard.lua
    │   ├── diffview.lua
    │   ├── fugitive.lua
    │   ├── gitsigns.lua
    │   ├── gruvbox.lua
    │   ├── indentline.lua
    │   ├── lazygit.lua
    │   ├── lsp.lua
    │   ├── lualine.lua
    │   ├── notify.lua
    │   ├── nvimtree.lua
    │   ├── persisted.lua
    │   ├── project.lua
    │   ├── snippets.lua
    │   ├── surround.lua
    │   ├── telescope.lua
    │   ├── telescope-fzf-native.lua
    │   ├── toggleterm.lua
    │   ├── treesitter.lua
    │   ├── web-devicons.lua
    │   └── whichkey.lua
    └── snippets               # Custom snippets
        ├── html.lua
        └── react.lua
```

---

## ✨ Features

* ⚡ **Lazy.nvim** – modern plugin manager
* 🎨 **UI Enhancements** – Gruvbox theme, Lualine, Bufferline, Dashboard, Notify
* 🔍 **Fuzzy Finder** – Telescope + fzf-native
* 🧠 **LSP + Autocompletion** – `nvim-lspconfig`, `cmp`, snippets
* 🌲 **Treesitter** – better syntax highlighting and code parsing
* 🔄 **Git Integration** – Fugitive, Lazygit, Gitsigns, Diffview
* 📝 **Productivity Tools** – Autopairs, Surround, Comment.nvim, ToggleTerm, Project management
* 🤖 **AI Integration** – GitHub Copilot, Codeium
* 💾 **Persistence** – session management with `persisted.nvim`
* 📦 **Snippets** – HTML & React snippets included

---

## ⚙️ Installation

### 1. Prerequisites

* [Neovim 0.11+](https://neovim.io/) (Nightly or Stable ≥ 0.11)
* [Git](https://git-scm.com/)
* A [Nerd Font](https://www.nerdfonts.com/) for icons
* (Optional) [Ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep
* Node.js & npm (for Copilot / Codeium)
* `build-essential` & `clang` (for Treesitter)

### 2. Clone the Config

```bash
# Backup old config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone KNV
git clone https://github.com/kabirajpan/KNV.git ~/.config/nvim

# Open Neovim to install plugins
nvim
```

Lazy.nvim will automatically install all plugins.

---

## 🎹 Key Features / Shortcuts

| Shortcut      | Action                    |
| ------------- | ------------------------- |
| `<leader> ff` | Find files (Telescope)    |
| `<leader> fg` | Live grep                 |
| `<leader> gs` | Git status (Fugitive)     |
| `<leader> gg` | Lazygit                   |
| `<leader> e`  | File explorer (nvim-tree) |
| `<leader> p`  | Project switcher          |
| `<leader> tt` | Toggle terminal           |
| `<leader> q`  | Quit session              |
| `<leader> ss` | Save session              |

*(Leader key = Space)*

---

## 🛠️ Customization

* Add new plugins inside `lua/plugins/`
* Adjust settings in `lua/core/options.lua`
* Update keymaps in `lua/core/keymaps.lua`
* Change themes & UI tweaks in `lua/core/ui.lua`

---

## 📜 License

MIT – free to use and modify.

---

## 👨‍💻 Author

Kabiraj Pan
🔗 GitHub: [https://github.com/kabirajpan](https://github.com/kabirajpan)
📧 Email: [kabirajpan2@gmail.com](mailto:kabirajpan2@gmail.com)
