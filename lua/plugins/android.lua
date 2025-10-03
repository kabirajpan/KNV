-- lua/plugins/android.lua  
-- Android development support for Neovim

return {
  -- Kotlin syntax support
  {
    "udalov/kotlin-vim",
    ft = "kotlin",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "kotlin",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true
          
          -- Android build keymaps
          local opts = { noremap=true, silent=true, buffer = true }
          vim.keymap.set('n', '<leader>ab', '<cmd>!./gradlew assembleDebug<CR>', opts)
          vim.keymap.set('n', '<leader>ai', '<cmd>!./gradlew installDebug<CR>', opts)
          vim.keymap.set('n', '<leader>ar', '<cmd>!./gradlew assembleRelease<CR>', opts)
          vim.keymap.set('n', '<leader>ac', '<cmd>!./gradlew clean<CR>', opts)
          vim.keymap.set('n', '<leader>al', '<cmd>!adb logcat<CR>', opts)
          vim.keymap.set('n', '<leader>ad', '<cmd>!adb devices<CR>', opts)
        end,
      })
    end,
  },

  -- Add same keymaps for Java files
  {
    "vim-scripts/groovy.vim",
    ft = "groovy",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          -- Android build keymaps for Java files too
          local opts = { noremap=true, silent=true, buffer = true }
          vim.keymap.set('n', '<leader>ab', '<cmd>!./gradlew assembleDebug<CR>', opts)
          vim.keymap.set('n', '<leader>ai', '<cmd>!./gradlew installDebug<CR>', opts)
          vim.keymap.set('n', '<leader>ar', '<cmd>!./gradlew assembleRelease<CR>', opts)
          vim.keymap.set('n', '<leader>ac', '<cmd>!./gradlew clean<CR>', opts)
          vim.keymap.set('n', '<leader>al', '<cmd>!adb logcat<CR>', opts)
          vim.keymap.set('n', '<leader>ad', '<cmd>!adb devices<CR>', opts)
        end,
      })
    end,
  },

  -- XML support for Android layouts
  {
    "othree/xml.vim",
    ft = "xml",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "xml",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true
        end,
      })
    end,
  },
}
