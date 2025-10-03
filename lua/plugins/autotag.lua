return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup {}

    -- Add this line to integrate with Treesitter
    require("nvim-treesitter.configs").setup {
      autotag = { enable = true },
    }
  end,
}

