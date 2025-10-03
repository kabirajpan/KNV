return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 12,
      open_mapping = [[<c-t>]],
      direction = "horizontal",
      close_on_exit = true,
      start_in_insert = true,
      
      on_create = function(term)
        vim.api.nvim_buf_set_option(term.bufnr, "buflisted", false)
        vim.api.nvim_buf_set_option(term.bufnr, "buftype", "terminal")
      end,
    })
  end,
}
