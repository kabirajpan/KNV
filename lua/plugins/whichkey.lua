-- lua/plugins/whichkey.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
  end,
}
