-- lua/core/ui.lua

-- Set your default colorscheme here
local ok, _ = pcall(vim.cmd, "colorscheme gruvbox") -- change to tokyonight or catppuccin if needed

if not ok then
  vim.notify("Failed to load default colorscheme", vim.log.levels.WARN)
end

