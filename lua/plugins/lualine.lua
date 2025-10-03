return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- AI highlights
    vim.cmd([[
      highlight LualineCopilot guifg=#FFA500
      highlight LualineCodeium guifg=#00BFFF
      highlight LualineNone guifg=#888888
    ]])

    -- AI status function
    local function ai_status()
      local copilot_active = false
      local codeium_active = vim.g.codeium_enabled ~= false

      local ok, copilot = pcall(require, "copilot.api")
      if ok and copilot.status and copilot.status.data then
        local status = copilot.status.data.status
        if status == "Normal" or status == "InProgress" then
          copilot_active = true
        end
      end

      if copilot_active then
        return "%#LualineCopilot# Copilot"
      elseif codeium_active then
        return "%#LualineCodeium#󰘦 Codeium"
      else
        return "%#LualineNone#󰦜 None"
      end
    end

    -- Relative path function
    local function relative_path()
      local filepath = vim.fn.expand("%:~:.")  -- relative to current dir
      if filepath == "" then
        filepath = "[No Name]"
      end
      return filepath
    end

    require("lualine").setup({
      options = {
        theme = "gruvbox",
        section_separators = "",
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { relative_path }, -- Relative path here
        lualine_x = { ai_status, "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}

