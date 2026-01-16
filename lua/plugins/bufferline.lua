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
        separator_style = "thick",
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_buffer_icons = true,
        always_show_bufferline = true,
        enforce_regular_tabs = false,
        tab_size = 18,
        max_name_length = 25,
        max_prefix_length = 3,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "  File Explorer",
            text_align = "left",
            separator = true,
          },
        },
        custom_filter = function(buf_number, buf_names)
          if vim.fn.getbufvar(buf_number, "&filetype") ~= "help" then
            return true
          end
          return false
        end,
      },
    }

  end,
}


