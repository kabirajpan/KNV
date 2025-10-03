return {
  "nvim-telescope/telescope-project.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension("project")
  end,
  keys = {
    { "<leader>fp", "<cmd>Telescope project<CR>", desc = "Projects" },
  },
}

