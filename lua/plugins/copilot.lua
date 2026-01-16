return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  build = ":Copilot auth",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = false,
        auto_trigger = false,
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

