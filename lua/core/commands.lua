vim.api.nvim_create_user_command("Theme", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, {})

