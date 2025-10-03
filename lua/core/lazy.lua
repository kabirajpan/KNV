-- lua/core/lazy.lua

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Load all plugins from plugins/init.lua
require("lazy").setup("plugins", {
  ui = {
    border = "rounded", -- Better Lazy UI
  },
  install = {
    colorscheme = { "gruvbox", "tokyonight" }, -- fallback themes
  },
})

