return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local api = require("nvim-tree.api")

    local function on_attach(bufnr)
      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- 📂 Open file/folder with Enter or mouse click
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open file or folder"))
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Mouse: open file/folder"))
      
       -- Real NvimTree keybindings
      vim.keymap.set("n", "a", api.fs.create, opts("Create"))
      vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
      vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))

      -- Add more keymaps here if needed
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      view = {
        width = 35,
        side = "left",
        preserve_window_proportions = true,
      },
      update_focused_file = {
        enable = true,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    })
  end,
}

