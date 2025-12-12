vim.opt.clipboard = "unnamedplus"  -- Add this line!
-- ~/.config/nvim/init.lua
require("core")

-- FIX: External clipboard support


if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.8
  vim.g.neovide_input_use_logo = 1  -- Better key handling (optional)
  
  -- Increase scale
  vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end)
  -- Decrease scale
  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end)
  -- Reset scale
  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
end