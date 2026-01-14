# Neovim Development Setup Guide

> **Complete mobile (Android/KMP) + backend (Spring Boot) development environment**  
> Optimized for terminal-based workflow with physical device testing

---

## 📋 Table of Contents

- [Overview](#overview)
- [What We Fixed](#what-we-fixed)
- [What We Added](#what-we-added)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Features Guide](#features-guide)
- [Keybindings Reference](#keybindings-reference)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Overview

This Neovim configuration provides a complete IDE-like experience for:
- **Android Development** (Kotlin, Java, XML)
- **Kotlin Multiplatform (KMP)**
- **Spring Boot Backend** (Java, Kotlin)
- **Web Development** (TypeScript, React, HTML/CSS)
- **General Programming** (Python, Rust, Go, C/C++, etc.)

### System Requirements

- Neovim 0.12+ (dev build recommended)
- Java 21+ (OpenJDK)
- Gradle 8.5+
- Maven 3.8+
- Node.js (for some LSP servers)
- Git

---

## 🔧 What We Fixed

### Performance Optimizations

**Before:** 872ms startup time  
**After:** 215ms startup time (75% faster!)

#### Changes Made:

1. **lazy.nvim Performance Tuning**
   - Enabled plugin caching
   - Disabled unused Neovim built-in plugins (gzip, tar, zip, netrw, tutor)
   - Disabled auto-update checker
   - File: `lua/core/lazy.lua`

2. **LSP Performance**
   - Added debounce (150ms general, 300ms for Kotlin)
   - Merged duplicate Kotlin LSP configs
   - Deleted: `lua/plugins/kotlin-lsp.lua` (merged into `lsp.lua`)
   - File: `lua/plugins/lsp.lua`

3. **Treesitter Optimization**
   - Disabled for files > 100KB
   - Disabled indent for YAML/Python (problematic languages)
   - Autotag only for web files
   - Disabled incremental selection (conflicted with `<CR>` mapping)
   - File: `lua/plugins/treesitter.lua`

4. **Plugin Fixes**
   - Removed broken `vim-logcat` plugin (authentication error)
   - Fixed `rest.nvim` dependencies (added nvim-nio, mimetypes, xml2lua)
   - File: `lua/plugins/rest-client.lua`

5. **AI Toggle Fix**
   - F9/F10 now properly refreshes lualine status
   - Added `lualine.refresh()` call
   - File: `lua/core/keymaps.lua`

---

## 🚀 What We Added

### New Plugin Files (8 total)

#### 1. **android.lua** - Enhanced Android/KMP Development
**Location:** `lua/plugins/android.lua`

**Features:**
- Gradle commands (build, install, clean, test, lint)
- ADB integration (device management, logcat, shell, screenshot)
- Device picker for multi-device testing
- KMP-specific commands

**Commands:**
```vim
:AndroidBuild          " Build debug APK
:AndroidBuildRelease   " Build release APK
:AndroidInstall        " Install to connected device
:AndroidUninstall      " Uninstall app from device
:AndroidClean          " Clean build artifacts
:AndroidTest           " Run unit tests
:AndroidLint           " Run lint checks
:AndroidDevices        " List connected devices
:AndroidLogcat         " Show logcat (optional: filter)
:AndroidLogcatClear    " Clear logcat buffer
:AndroidShell          " Open ADB shell
:AndroidScreenshot     " Take device screenshot
:KmpBuild              " Build KMP shared module
:KmpTest               " Run KMP tests
:KmpAndroid            " Build KMP Android target
```

**Keybindings:**
- `<leader>ab` - Android Build
- `<leader>ai` - Android Install
- `<leader>al` - Android Logcat
- `<leader>ac` - Android Clean
- `<leader>ad` - Android Devices

---

#### 2. **spring-boot.lua** - Spring Boot Development
**Location:** `lua/plugins/spring-boot.lua`

**Features:**
- Auto-detects Maven or Gradle
- Quick run/build/test/package commands
- Fast navigation to Spring components
- Application properties quick access

**Commands:**
```vim
:SpringRun             " Run Spring Boot application
:SpringBuild           " Build project
:SpringTest            " Run tests
:SpringClean           " Clean build artifacts
:SpringPackage         " Package JAR (skip tests)
:SpringProperties      " Open application.properties/yml
:SpringController      " Find Controllers
:SpringService         " Find Services
:SpringEntity          " Find Entities
:SpringRepository      " Find Repositories
```

**Keybindings:**
- `<leader>sr` - Spring Run
- `<leader>sb` - Spring Build
- `<leader>st` - Spring Test
- `<leader>sp` - Spring Properties
- `<leader>sc` - Spring Controller

---

#### 3. **rest-client.lua** - API Testing
**Location:** `lua/plugins/rest-client.lua`

**Features:**
- Test REST APIs directly from Neovim
- `.http` file support
- JSON formatting with `jq`
- Save and reuse API requests

**Commands:**
```vim
:RestRun               " Run request under cursor
:RestLast              " Run last request
:RestNew               " Create new .http file
```

**Usage Example:**
Create a file `api.http`:
```http
### Get Users
GET https://api.example.com/users
Content-Type: application/json

###

### Create User
POST https://api.example.com/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}
```

Press `<CR>` (Enter) on any request to execute it.

**Keybindings:**
- `<CR>` - Run request under cursor (in .http files)
- `<leader>rr` - Run request
- `<leader>rp` - Preview request
- `<leader>rl` - Run last request
- `<leader>rn` - New .http file

---

#### 4. **project-manager.lua** - Multi-Project Management
**Location:** `lua/plugins/project-manager.lua`

**Features:**
- Auto-detects project type (Android, Spring Boot, Gradle, Maven, Node)
- Quick project switching with Telescope
- Shows available commands per project type

**Commands:**
```vim
:ProjectInfo           " Show current project type and commands
```

**Keybindings:**
- `<leader>pp` - Project Picker (Telescope)
- `<leader>pi` - Project Info

---

#### 5. **code-navigation.lua** - Smart File Navigation
**Location:** `lua/plugins/code-navigation.lua`

**Features:**
- Jump between related files automatically
- Spring Boot: Controller → Service → Repository → Entity
- Android: Activity → ViewModel → Fragment
- Auto-create test files with templates

**Commands:**
```vim
:RelatedFiles          " Find files related to current file
:JumpToTest            " Jump to test file (creates if missing)
```

**Keybindings:**
- `<leader>gf` - Go to Related Files
- `<leader>gt` - Go to Test
- `<leader>fc` - Find Controllers
- `<leader>fs` - Find Services
- `<leader>fr` - Find Repositories
- `<leader>fe` - Find Entities
- `<leader>fv` - Find ViewModels
- `<leader>fa` - Find Activities

**Example Workflow:**
1. Open `UserController.kt`
2. Press `<leader>gf`
3. See list: `UserService.kt`, `UserRepository.kt`, `User.kt`
4. Select and jump to file

---

#### 6. **git-enhanced.lua** - Advanced Git Integration
**Location:** `lua/plugins/git-enhanced.lua`

**Features:**
- Inline git blame
- Visual diff viewer
- Conflict resolution helper
- Hunk staging/unstaging

**Keybindings:**

**Navigation:**
- `]c` - Next git change
- `[c` - Previous git change
- `]x` - Next conflict
- `[x` - Previous conflict

**Hunk Actions:**
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `<leader>hd` - Diff this
- `<leader>tb` - Toggle blame display

**Git Operations:**
- `<leader>gg` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gP` - Git pull
- `<leader>gb` - Git blame
- `<leader>gL` - Git log
- `<leader>gd` - Diff view
- `<leader>gh` - File history
- `<leader>gH` - Repo history

**Conflict Resolution:**
- `<leader>co` - Choose ours
- `<leader>ct` - Choose theirs
- `<leader>cb` - Choose both
- `<leader>c0` - Choose none
- `<leader>cl` - List conflicts

---

#### 7. **terminal-enhanced.lua** - Advanced Terminal Management
**Location:** `lua/plugins/terminal-enhanced.lua`

**Features:**
- Multiple terminal instances
- Dedicated Gradle/Maven terminals
- REPL support (Kotlin, Python, Node)
- Send code selection to terminal

**Keybindings:**

**Terminals:**
- `<C-`>` - Toggle main terminal
- `<leader>t1` - Terminal 1
- `<leader>t2` - Terminal 2
- `<leader>tf` - Floating terminal
- `<leader>tg` - Gradle terminal
- `<leader>tm` - Maven terminal

**REPLs:**
- `<leader>rk` - Kotlin REPL
- `<leader>rp` - Python REPL
- `<leader>rn` - Node REPL

**Other:**
- `<leader>ts` - Send selection to terminal (visual mode)

**Terminal Mode Navigation:**
- `<Esc>` or `jk` - Exit terminal mode
- `<C-h/j/k/l>` - Navigate between windows

---

#### 8. **build-automation.lua** - Build & Format Automation
**Location:** `lua/plugins/build-automation.lua`

**Features:**
- Auto-format on save (can be toggled)
- Universal `:Build` and `:Test` commands (auto-detects project)
- Error display with Trouble.nvim
- Build notifications

**Commands:**
```vim
:Build                 " Build current project (auto-detects)
:Test                  " Run tests (auto-detects)
:ConformInfo           " Show formatter info
```

**Keybindings:**
- `<leader>bb` - Build project
- `<leader>bt` - Run tests
- `<leader>cf` - Format code manually
- `<leader>tf` - Toggle auto-format on save
- `<leader>xx` - Show all diagnostics (Trouble)
- `<leader>xX` - Show buffer diagnostics
- `<leader>xQ` - Quickfix list

**Supported Formatters:**
- Lua: stylua
- Java: google-java-format
- Kotlin: ktlint
- JavaScript/TypeScript: prettier
- Python: black
- Rust: rustfmt
- C/C++: clang-format
- Shell: shfmt

---

## 📥 Installation

### Prerequisites

```bash
# Install required tools
sudo apt install ripgrep fd-find jq git curl

# Install formatters (optional but recommended)
sudo apt install clang-format
pip install black
npm install -g prettier

# For Kotlin formatting
# Download ktlint from: https://github.com/pinterest/ktlint
```

### Setup Steps

1. **Backup existing config** (if any):
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. **Clone this configuration**:
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. **First launch** (will install plugins):
```bash
nvim
```

Wait for lazy.nvim to install all plugins (~2-3 minutes).

4. **Install LSP servers**:
```vim
:Mason
```

Press `i` to install these servers:
- kotlin_language_server
- jdtls
- lua_ls
- ts_ls
- pyright
- rust_analyzer

5. **Verify installation**:
```vim
:checkhealth
```

---

## 🎓 Quick Start

### For Android Development

```bash
# Navigate to your Android project
cd ~/projects/my-android-app

# Open Neovim
nvim

# Check project info
:ProjectInfo

# Build and install
:AndroidBuild
:AndroidInstall

# Watch logs with filter
:AndroidLogcat myapp
```

### For Spring Boot Development

```bash
# Navigate to Spring Boot project
cd ~/projects/my-spring-app

# Open Neovim
nvim

# Run application
:SpringRun

# In another terminal/tab
<leader>t2    # Open second terminal
# Then test your API
```

### For API Testing

```bash
# Create API test file
:RestNew api.http

# Add requests (template will be inserted)
# Press <CR> on any request to run it
```

---

## 📖 Features Guide

### AI Assistance (Copilot + Codeium)

You have TWO AI assistants available:

**Toggle Between Them:**
- `F9` - Switch: Copilot ↔ Codeium
- `F10` - Disable/Enable ALL AI

**Status Display:**
Look at the bottom-right of your screen (lualine):
- ` Copilot` - Copilot is active (orange)
- `󰘦 Codeium` - Codeium is active (blue)
- `󰦜 None` - AI disabled (gray)

**Accepting Suggestions:**
- `<Tab>` - Accept AI suggestion (works with both)
- `<C-j>` - Accept Copilot suggestion
- `<A-CR>` - Accept Codeium suggestion
- `<C-l>` - Next Copilot suggestion
- `<C-h>` - Previous Copilot suggestion

### LSP Features

**20 Language Servers Installed:**
- Java (jdtls)
- Kotlin (kotlin_language_server)
- TypeScript/JavaScript (ts_ls)
- Python (pyright)
- Lua (lua_ls)
- Rust (rust_analyzer)
- Go (gopls)
- And 13 more...

**Common LSP Keybindings:**
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<F2>` - Rename (alternative)
- `<F12>` - Go to definition (alternative)
- `<S-F12>` - Find references (alternative)

### File Navigation

**File Explorer:**
- `<C-e>` - Toggle file tree (works in all modes)
- In file tree: Double-click or `<CR>` to open file

**Fuzzy Finding (Telescope):**
- `<C-p>` - Find files
- `<C-S-f>` - Search in files (live grep)
- `<C-b>` - List open buffers
- `<leader>ff` - Find files (alternative)
- `<leader>fg` - Live grep (alternative)
- `<leader>fb` - Buffers (alternative)

**Buffer Navigation:**
- `<A-Left>` - Previous buffer
- `<A-Right>` - Next buffer
- `<A-S-Left>` - Move buffer tab left
- `<A-S-Right>` - Move buffer tab right
- `<C-w>` - Close buffer
- `<C-n>` - New buffer

### Editing Features

**VS Code-like Keybindings:**
- `<C-s>` - Save file
- `<C-c>` - Copy (line or selection)
- `<C-x>` - Cut (line or selection)
- `<C-v>` - Paste
- `<C-z>` - Undo
- `<C-y>` - Redo
- `<C-a>` - Select all
- `<C-/>` - Toggle comment
- `<C-f>` - Find
- `<C-h>` - Find and replace

**Line Operations:**
- `<A-Up>` - Move line up
- `<A-Down>` - Move line down
- `<A-S-Up>` - Duplicate line up
- `<A-S-Down>` - Duplicate line down
- `<C-S-k>` - Delete line

**Selection:**
- `<S-Arrow>` - Select characters
- `<C-S-Arrow>` - Select words
- `<S-Home>` - Select to line start
- `<S-End>` - Select to line end

### Terminal Usage

**Basic Terminal:**
```vim
<C-`>    " Toggle terminal
<Esc>    " Exit terminal mode
```

**Multiple Terminals:**
```vim
<leader>t1    " Open terminal 1 (general purpose)
<leader>t2    " Open terminal 2 (build/compile)
<leader>tf    " Floating terminal
```

**Specialized Terminals:**
```vim
<leader>tg    " Gradle terminal
<leader>tm    " Maven terminal
<leader>rk    " Kotlin REPL
<leader>rp    " Python REPL
<leader>rn    " Node REPL
```

**Send Code to Terminal:**
1. Select code in visual mode
2. Press `<leader>ts`
3. Code runs in active terminal/REPL

---

## 🎹 Complete Keybindings Reference

### Leader Key
Leader key is `<Space>` (spacebar)

### Android/KMP Development
| Key | Action |
|-----|--------|
| `<leader>ab` | Android Build |
| `<leader>ai` | Android Install |
| `<leader>al` | Android Logcat |
| `<leader>ac` | Android Clean |
| `<leader>ad` | Android Devices |

### Spring Boot Development
| Key | Action |
|-----|--------|
| `<leader>sr` | Spring Run |
| `<leader>sb` | Spring Build |
| `<leader>st` | Spring Test |
| `<leader>sp` | Spring Properties |
| `<leader>sc` | Spring Controller |

### Code Navigation
| Key | Action |
|-----|--------|
| `<leader>gf` | Related Files |
| `<leader>gt` | Jump to Test |
| `<leader>fc` | Find Controllers |
| `<leader>fs` | Find Services |
| `<leader>fr` | Find Repositories |
| `<leader>fe` | Find Entities |
| `<leader>fv` | Find ViewModels |
| `<leader>fa` | Find Activities |

### Git Operations
| Key | Action |
|-----|--------|
| `<leader>hs` | Stage Hunk |
| `<leader>hr` | Reset Hunk |
| `<leader>hp` | Preview Hunk |
| `<leader>hb` | Blame Line |
| `<leader>tb` | Toggle Blame |
| `<leader>gg` | Git Status |
| `<leader>gc` | Git Commit |
| `<leader>gp` | Git Push |
| `<leader>gP` | Git Pull |
| `<leader>gd` | Diff View |
| `<leader>gh` | File History |
| `<leader>gH` | Repo History |
| `]c` | Next Change |
| `[c` | Previous Change |
| `]x` | Next Conflict |
| `[x` | Previous Conflict |
| `<leader>co` | Conflict: Choose Ours |
| `<leader>ct` | Conflict: Choose Theirs |
| `<leader>cb` | Conflict: Choose Both |
| `<leader>cl` | List Conflicts |

### Terminal & REPL
| Key | Action |
|-----|--------|
| `<C-`>` | Toggle Main Terminal |
| `<leader>t1` | Terminal 1 |
| `<leader>t2` | Terminal 2 |
| `<leader>tf` | Floating Terminal |
| `<leader>tg` | Gradle Terminal |
| `<leader>tm` | Maven Terminal |
| `<leader>rk` | Kotlin REPL |
| `<leader>rp` | Python REPL |
| `<leader>rn` | Node REPL |
| `<leader>ts` | Send Selection to Terminal |

### Build & Format
| Key | Action |
|-----|--------|
| `<leader>bb` | Build Project |
| `<leader>bt` | Run Tests |
| `<leader>cf` | Format Code |
| `<leader>tf` | Toggle Auto-Format |
| `<leader>xx` | Show All Errors |
| `<leader>xX` | Show Buffer Errors |

### Project Management
| Key | Action |
|-----|--------|
| `<leader>pp` | Project Picker |
| `<leader>pi` | Project Info |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gr` | Find References |
| `K` | Hover Documentation |
| `<leader>rn` | Rename |
| `<leader>ca` | Code Action |
| `<F2>` | Rename (alt) |
| `<F12>` | Go to Definition (alt) |

### AI
| Key | Action |
|-----|--------|
| `F9` | Toggle Copilot ↔ Codeium |
| `F10` | Disable/Enable AI |
| `<Tab>` | Accept Suggestion |
| `<C-j>` | Accept Copilot |
| `<A-CR>` | Accept Codeium |

### File Operations
| Key | Action |
|-----|--------|
| `<C-e>` | Toggle File Tree |
| `<C-p>` | Find Files |
| `<C-S-f>` | Search in Files |
| `<C-b>` | Buffer List |
| `<C-s>` | Save |
| `<C-w>` | Close Buffer |
| `<C-n>` | New Buffer |

### Buffer Navigation
| Key | Action |
|-----|--------|
| `<A-Left>` | Previous Buffer |
| `<A-Right>` | Next Buffer |
| `<A-S-Left>` | Move Buffer Left |
| `<A-S-Right>` | Move Buffer Right |

### Editing
| Key | Action |
|-----|--------|
| `<C-c>` | Copy |
| `<C-x>` | Cut |
| `<C-v>` | Paste |
| `<C-z>` | Undo |
| `<C-y>` | Redo |
| `<C-a>` | Select All |
| `<C-/>` | Toggle Comment |
| `<A-Up>` | Move Line Up |
| `<A-Down>` | Move Line Down |
| `<A-S-Up>` | Duplicate Line Up |
| `<A-S-Down>` | Duplicate Line Down |
| `<C-S-k>` | Delete Line |

---

## 🔧 Troubleshooting

### Slow Startup
```vim
:Lazy profile
```
Check which plugins are slow. Consider lazy-loading more aggressively.

### LSP Not Working
```vim
:LspInfo          " Check active LSP servers
:Mason            " Reinstall language server
:checkhealth lsp  " Full LSP health check
```

### Formatter Not Working
```vim
:ConformInfo      " Check formatter status
:Mason            " Install missing formatters
```

### AI Not Working
```vim
" Check Copilot status
:Copilot status

" Toggle to Codeium
F9

" Disable and re-enable
F10
F10
```

### Terminal Issues
If terminal paste doesn't work:
- Use `<C-S-v>` in terminal mode
- Or use `<S-Insert>`

### Keybinding Conflicts
```vim
:verbose map <key>    " Check what <key> is mapped to
```

---

## 📝 Notes

### Neovide Users
All features work in Neovide GUI. Special Neovide configurations:
- Scale: `<C-=>` zoom in, `<C-->` zoom out, `<C-0>` reset
- Ctrl+E and Ctrl+V have special handling for Neovide

### File Structure
```
~/.config/nvim/
├── init.lua                      # Entry point
├── lua/
│   ├── core/
│   │   ├── init.lua             # Core loader
│   │   ├── lazy.lua             # Plugin manager config
│   │   ├── options.lua          # Vim options
│   │   ├── keymaps.lua          # Global keymaps
│   │   └── commands.lua         # User commands
│   ├── plugins/
│   │   ├── android.lua          # Android/KMP (NEW)
│   │   ├── spring-boot.lua      # Spring Boot (NEW)
│   │   ├── rest-client.lua      # API testing (NEW)
│   │   ├── project-manager.lua  # Projects (NEW)
│   │   ├── code-navigation.lua  # Navigation (NEW)
│   │   ├── git-enhanced.lua     # Git (NEW)
│   │   ├── terminal-enhanced.lua # Terminal (NEW)
│   │   ├── build-automation.lua # Build (NEW)
│   │   ├── lsp.lua              # LSP (UPDATED)
│   │   ├── treesitter.lua       # Treesitter (UPDATED)
│   │   ├── cmp.lua              # Completion
│   │   ├── copilot.lua          # Copilot AI
│   │   ├── codeium.lua          # Codeium AI
│   │   ├── lualine.lua          # Statusline
│   │   ├── telescope.lua        # Fuzzy finder
│   │   └── ...                  # Other plugins
│   └── snippets/
│       ├── html.lua
│       └── react.lua
└── README.md
```

### Performance Tips
- Disable AI when not needed: `F10`
- Use `:Build` instead of opening separate terminals
- Close unused buffers: `<C-w>`
- Use project picker for large workspaces: `<leader>pp`

---

## 🎉 Credits

**Plugins Used:**
- lazy.nvim - Plugin manager
- nvim-lspconfig - LSP configuration
- nvim-cmp - Autocompletion
- nvim-treesitter - Syntax highlighting
- telescope.nvim - Fuzzy finder
- gitsigns.nvim - Git integration
- toggleterm.nvim - Terminal management
- conform.nvim - Formatting
- trouble.nvim - Diagnostics
- rest.nvim - API testing
- And 40+ more amazing plugins!

---

## 📄 License

This configuration is free to use and modify.

---

**Happy Coding! 🚀**

For questions or issues, refer to the troubleshooting section or check `:checkhealth`.