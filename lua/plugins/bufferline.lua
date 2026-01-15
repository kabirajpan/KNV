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
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_buffer_icons = true,
        always_show_bufferline = true,
        enforce_regular_tabs = false,
        tab_size = 16,
        max_name_length = 20,
        max_prefix_length = 10,
        diagnostics = "nvim_lsp",  -- Show LSP errors/warnings in buffers
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return icon .. count
        end,
        custom_filter = function(buf_number)
          -- Filter out certain buffers
          if vim.fn.getbufvar(buf_number, "&buftype") ~= "" then
            return false
          end
          return true
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "  File Explorer",
            text_align = "left",
            separator = true,
            highlight = "PanelHeading",
          },
        },
      },
      highlights = {
        fill = {
          bg = "#1d2021"
        },
        background = {
          fg = "#928374",
          bg = "#282828"
        },
      }
    }

  end,
}

