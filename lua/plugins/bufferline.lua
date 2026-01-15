return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.opt.termguicolors = true
    vim.opt.showtabline = 2

    require("bufferline").setup {
      options = {
        mode = "buffers",
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        show_buffer_icons = true,
        always_show_bufferline = true,
        enforce_regular_tabs = false,
        tab_size = 18,
        max_name_length = 25,
        max_prefix_length = 3,
        diagnostics = nil,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Files",
            text_align = "left",
            separator = false,
          },
        },
      },
    }

  end,
}


