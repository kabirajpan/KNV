return {
  "olimorris/persisted.nvim",
  lazy = false,
  config = function()
    require("persisted").setup({
      autosave = true,
      autoload = true,
      should_autosave = function()
        -- Don’t save sessions for git commit messages or temporary buffers
        return vim.bo.filetype ~= "gitcommit" and not vim.bo.readonly
      end,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>qs", function()
      require("persisted").load()
    end, { desc = "Load session" })

    vim.keymap.set("n", "<leader>ql", function()
      require("persisted").load_last()
    end, { desc = "Load last session" })

    vim.keymap.set("n", "<leader>qd", function()
      require("persisted").stop()
    end, { desc = "Stop session autosave" })

    vim.keymap.set("n", "<leader>qw", function()
      require("persisted").save()
    end, { desc = "Save session manually" })
  end,
}

