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
        separator_style = { "", "" },
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = false,
        show_buffer_icons = true,
        always_show_bufferline = true,
        enforce_regular_tabs = false,
        tab_size = 16,
        max_name_length = 20,
        max_prefix_length = 10,
        diagnostics = nil,      -- hide LSP errors/warnings
        numbers = function() return "" end,  -- hide numbers
        offsets = {
          {
            filetype = "NvimTree",
            text = "📁 Explorer",
            text_align = "center",
            separator = true,
            highlight = "Directory",
          },
        },
      },
    }

  end,
}

