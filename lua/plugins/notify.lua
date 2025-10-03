return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    notify.setup({
      stages = "slide",              -- Smooth animation
      timeout = 4000,                -- 4 seconds visibility
      top_down = false,              -- New messages appear at bottom
      background_colour = "#000000", -- Transparent background
      render = "wrapped-compact",    -- Tight layout
      max_width = 80,
      fps = 60,
    })

    -- Advanced filtering logic
    local filtered_patterns = {
      "Schema download timed out",
      "duplicate registry",
      "not a valid entry in ensure_installed",
      "failed to install",
    }

    -- Optionally log to a file (toggle this with `log_to_file`)
    local log_to_file = false
    local log_path = vim.fn.stdpath("cache") .. "/notify.log"

    ---@param msg string
    ---@return boolean
    local function is_filtered(msg)
      for _, pattern in ipairs(filtered_patterns) do
        if msg:lower():match(pattern:lower()) then
          return true
        end
      end
      return false
    end

    ---@param msg string
    ---@param level number
    ---@param opts table
    vim.notify = function(msg, level, opts)
      opts = opts or {}

      -- Filter unwanted messages
      if type(msg) == "string" and is_filtered(msg) then
        return
      end

      -- Optional: log everything to file
      if log_to_file then
        local log_msg = string.format(
          "[%s] [%s] %s\n",
          os.date("%Y-%m-%d %H:%M:%S"),
          vim.log.levels[level] or "INFO",
          msg
        )
        local f = io.open(log_path, "a")
        if f then
          f:write(log_msg)
          f:close()
        end
      end

      notify(msg, level, opts)
    end
  end,
}

