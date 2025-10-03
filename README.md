# ✨ KNV
**Kabiraj’s Neovim Configuration**

A modern, modular, and blazing fast Neovim setup powered by **Lazy.nvim**.
It’s designed to be **modular, fast, and developer-friendly**, with features for **coding, git, UI enhancements, and productivity**.

---

## 📂 Project Structure

.
├── init.lua # Entry point
├── lazy-lock.json # Plugin version lockfile
└── lua
├── core # Core configuration
│ ├── autocmds.lua
│ ├── commands.lua
│ ├── duplicate_window_fix.lua
│ ├── init.lua
│ ├── keymaps.lua
│ ├── lazy.lua
│ ├── options.lua
│ └── ui.lua
├── plugins # Plugin configs
│ ├── android.lua
│ ├── autopairs.lua
│ ├── autotag.lua
│ ├── barbecue.lua
│ ├── bufferline.lua
│ ├── cmp.lua
│ ├── codeium.lua
│ ├── comment.lua
│ ├── conform.lua
│ ├── copilot.lua
│ ├── dashboard.lua
│ ├── diffview.lua
│ ├── fugitive.lua
│ ├── gitsigns.lua
│ ├── gruvbox.lua
│ ├── indentline.lua
│ ├── lazygit.lua
│ ├── lsp.lua
│ ├── lualine.lua
│ ├── notify.lua
│ ├── nvimtree.lua
│ ├── persisted.lua
│ ├── project.lua
│ ├── snippets.lua
│ ├── surround.lua
│ ├── telescope.lua
│ ├── telescope-fzf-native.lua
│ ├── toggleterm.lua
│ ├── treesitter.lua
│ ├── web-devicons.lua
│ └── whichkey.lua
└── snippets # Custom snippets
├── html.lua
└── react.lua

markdown
Copy code

---

## ✨ Features

- ⚡ **Lazy.nvim** – modern plugin manager  
- 🎨 **UI Enhancements** – Gruvbox theme, Lualine, Bufferline, Dashboard, Notify  
- 🔍 **Fuzzy Finder** – Telescope + fzf-native  
- 🧠 **LSP + Autocompletion** – `nvim-lspconfig`, `cmp`, snippets  
- 🌲 **Treesitter** – better syntax highlighting and code parsing  
- 🔄 **Git Integration** – Fugitive, Lazygit, Gitsigns, Diffview  
- 📝 **Productivity Tools** – Autopairs, Surround, Comment.nvim, ToggleTerm, Project management  
- 🤖 **AI Integration** – GitHub Copilot, Codeium  
- 💾 **Persistence** – session management with `persisted.nvim`  
- 📦 **Snippets** – HTML & React snippets included  

---

## ⚙️ Installation

### 1. Prerequisites
- [Neovim 0.9+](https://neovim.io/)
- [Git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- (Optional) [Ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep

### 2. Clone the Config
```bash
mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/kabirajpan/nvim-config.git ~/.config/nvim

nvim
## Lazy.nvim will automatically install and sync plugins.

🎹 Key Features / Shortcuts
<leader> ff – Find files (Telescope)

<leader> fg – Live grep

<leader> gs – Git status (Fugitive)

<leader> gg – Lazygit

<leader> e – File explorer (nvim-tree)

<leader> p – Project switcher

<leader> tt – Toggle terminal

<leader> q – Quit session

<leader> ss – Save session

(Leader key = space)

📸 Screenshots
Add screenshots here (optional)

🛠️ Customization
Add new plugins inside lua/plugins/

Adjust settings in lua/core/options.lua

Update keymaps in lua/core/keymaps.lua

Themes & UI tweaks in lua/core/ui.lua

📜 License
MIT – free to use and modify.

👨‍💻 Author
Kabiraj Pan
🔗 GitHub
📧 kabirajpan2@gmail.com

yaml
Copy code

---

Would you like me to also make a **short version** (just features + install steps, no long explanation) for your GitHub repo front page?
