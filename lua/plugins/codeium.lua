return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "InsertEnter",
  config = function()
    require("codeium").setup({
      -- Enable telemetry (optional, can be disabled)
      enable_chat = true,
      
      -- Tools integration
      tools = {
        curl = vim.fn.executable("curl") == 1,
        gzip = vim.fn.executable("gzip") == 1,
        uname = vim.fn.executable("uname") == 1,
        uuidgen = vim.fn.executable("uuidgen") == 1,
      },
      
      -- Wrapper configuration
      wrapper = {
        path = vim.fn.stdpath("data") .. "/codeium/bin",
        curl_timeout = 30000,
      },
    })
    
    -- Add custom keymaps for Codeium
    local function set_codeium_keymaps()
      -- Accept Codeium suggestion with Alt+Enter (alternative to Tab)
      vim.keymap.set("i", "<A-CR>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
      
      -- Next suggestion
      vim.keymap.set("i", "<A-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true, desc = "Next Codeium suggestion" })
      
      -- Previous suggestion  
      vim.keymap.set("i", "<A-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })
      
      -- Clear suggestions
      vim.keymap.set("i", "<A-BS>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true, desc = "Clear Codeium suggestions" })
      
      -- Toggle Codeium
      vim.keymap.set("n", "<leader>ct", function()
        if vim.g.codeium_enabled == false then
          vim.cmd("CodeiumEnable")
          print("Codeium enabled")
        else
          vim.cmd("CodeiumDisable")
          print("Codeium disabled")
        end
      end, { desc = "Toggle Codeium" })
    end
    
    -- FIXED: Use vim.schedule instead of vim.schedule_callback
    vim.schedule(function()
      set_codeium_keymaps()
    end)
  end,
}