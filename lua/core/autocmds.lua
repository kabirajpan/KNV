vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Ensure Copilot is enabled on InsertEnter
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    local status_ok, _ = pcall(vim.cmd, "Copilot enable")
    if status_ok then
      vim.notify("Copilot enabled", vim.log.levels.INFO)
    end
  end,
})



-- Fix Ctrl+Z terminal suspension (delayed to not conflict with dashboard)
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  once = true,
  callback = function()
    vim.defer_fn(function()
      -- Only run if not in dashboard
      if vim.bo.filetype ~= "dashboard" then
        vim.fn.system("stty -ixon")
      end
    end, 200)
  end,
})
