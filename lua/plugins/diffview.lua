return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git Diff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "File History" },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
}

