-- core/duplicate_window_fix.lua

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buf)

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if buf ~= current_buf and vim.api.nvim_buf_get_name(buf) == current_file then
        vim.api.nvim_win_close(0, true)
        vim.notify("Closed duplicate buffer window", vim.log.levels.INFO)
        return
      end
    end
  end,
})

