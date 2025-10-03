return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#ebd11f", bold = true })
    local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local i = 0
    local footer = { "Loading..." }
    
    -- Setup dashboard
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = {
          [[  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[ ||     ██╗  ██╗   █████╗   ██████╗   ██╗  ██████╗      ||  ]],
          [[ ||     ██║ ██╔╝  ██╔══██╗  ██╔══██╗  ██║  ██╔══██╗     ||  ]],
          [[ ||     █████╔╝   ███████║  ██████╦╝  ██║  ██████╔╝     ||  ]],
          [[ ||     ██╔═██╗   ██╔══██║  ██╔══██╗  ██║  ██╔══██╗     ||  ]],
          [[ ||     ██║  ██╗  ██║  ██║  ██████╦╝  ██║  ██║  ██║     ||  ]],
          [[ ||     ╚═╝  ╚═╝  ╚═╝  ╚═╝  ╚═════╝   ╚═╝  ╚═╝  ╚═╝     ||  ]],
          [[                                                ]],
          [[            github.com/kabirajpan               ]],
          [[           Hello,   KABIR                     ]],
          [[                                                ]],
        },
        center = {
          { desc = "╭────────────────────────────────────────────╮", action = "" },
          {
            icon = "|    ",
            icon_hl = "Title",
            desc = "Find File",
            desc_hl = "String",
            key = "f",
            key_hl = "Number",
            key_format = " [%s]",
            action = "Telescope find_files",
          },
          {
            icon = "|    ",
            icon_hl = "Title",
            desc = "Live Grep",
            desc_hl = "String",
            key = "g",
            key_hl = "Number",
            key_format = " [%s]",
            action = "Telescope live_grep",
          },
          {
            icon = "|    ",
            icon_hl = "Title",
            desc = "Recent Files",
            desc_hl = "String",
            key = "r",
            key_hl = "Number",
            key_format = " [%s]",
            action = "Telescope oldfiles",
          },
          {
            icon = "|    ",
            icon_hl = "Title",
            desc = "File Explorer",
            desc_hl = "String",
            key = "e",
            key_hl = "Number",
            key_format = " [%s]",
            action = "NvimTreeToggle",
          },
          {
            icon = "|    ",
            icon_hl = "Title",
            desc = "Edit Config",
            desc_hl = "String",
            key = "c",
            key_hl = "Number",
            key_format = " [%s]",
            action = "e ~/.config/nvim/init.lua",
          },
          {
            icon = "|    ",
            icon_hl = "Title",
            desc = "Quit",
            desc_hl = "String",
            key = "q",
            key_hl = "Number",
            key_format = " [%s]",
            action = "qa",
          },
          { desc = "╰────────────────────────────────────────────╯", action = "" },
        },
        footer = footer,
      },
    })
    
    -- Animate spinner AFTER dashboard loads
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardReady",
      callback = function()
        local function spin()
          i = (i % #frames) + 1
          footer[1] = "Loading... " .. frames[i]
          vim.cmd("redraw")
          vim.defer_fn(spin, 120)
        end
        spin()
      end,
    })
  end,
}
