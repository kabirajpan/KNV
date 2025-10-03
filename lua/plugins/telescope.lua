return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-tree/nvim-web-devicons",
    "rcarriga/nvim-notify", -- Use this instead
  },
  build = "make",
  event = "VeryLazy",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Notification History" },
    { "<leader>ut", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Pick Colorscheme" },
  },
  config = function()
    require("telescope").setup {
      defaults = {
        layout_config = {
          horizontal = { preview_width = 0.55 },
          vertical = { width = 0.9 },
        },
        file_ignore_patterns = { "node_modules", ".git/" },
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          themes = "dropdown",
        },
      },
    }

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "notify")
  end,
}

