return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  build = ":Copilot auth",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-j>",
          next = "<C-l>",
          prev = "<C-h>",
          dismiss = "<C-o>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = false,
        yaml = false,
        gitcommit = false,
      },
    })
  end,
}

