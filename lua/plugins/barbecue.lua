return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbecue").setup({
      attach_navic = false,       -- we only want relative path
      show_dirname = true,        -- show relative path
      show_basename = true,       -- show file name
      show_symbols = false,       -- no extra symbols
      separator = " / ",          -- path separator
      theme = "gruvbox",
    })
  end,
}

