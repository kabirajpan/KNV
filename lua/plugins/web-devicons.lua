-- lua/plugins/web-devicons.lua
-- Web Dev Icons with automatic Nerd Font detection and setup
return {
  "nvim-tree/nvim-web-devicons",
  lazy = false, -- Load eagerly for early icon availability
  config = function()
    local devicons = require("nvim-web-devicons")
    
    -- Check if Nerd font is available
    local function has_nerd_font()
      local font = vim.opt.guifont:get()
      if font and #font > 0 then
        for _, f in ipairs(font) do
          if f:match("Nerd Font") or f:match("FiraCode Nerd") or f:match("JetBrains Mono Nerd") or
             f:match("Inconsolata Nerd") or f:match("Hack Nerd") or f:match("DejaVu Nerd") then
            return true
          end
        end
      end
      return false
    end
    
    -- Setup web-devicons with enhanced config
    devicons.setup({
      override = {
        -- Common file types
        lua = { icon = "󰢱", color = "#51a0cf", name = "Lua" },
        json = { icon = "󰘦", color = "#e8d866", name = "JSON" },
        yaml = { icon = "󰘦", color = "#cb7552", name = "YAML" },
        yml = { icon = "󰘦", color = "#cb7552", name = "YAML" },
        py = { icon = "", color = "#3776ab", name = "Python" },
        js = { icon = "", color = "#f7df1e", name = "JavaScript" },
        ts = { icon = "", color = "#3178c6", name = "TypeScript" },
        tsx = { icon = "", color = "#3178c6", name = "TypeScript JSX" },
        jsx = { icon = "", color = "#61dafb", name = "JSX" },
        java = { icon = "", color = "#007396", name = "Java" },
        kt = { icon = "", color = "#7f52ff", name = "Kotlin" },
        gradle = { icon = "🐘", color = "#02303a", name = "Gradle" },
        xml = { icon = "󰠋", color = "#ff6b35", name = "XML" },
        html = { icon = "󰌐", color = "#e34c26", name = "HTML" },
        css = { icon = "󰌝", color = "#563d7c", name = "CSS" },
        md = { icon = "󰍔", color = "#519aba", name = "Markdown" },
        vim = { icon = "", color = "#019833", name = "Vim" },
        sh = { icon = "", color = "#4eca3d", name = "Shell" },
        rust = { icon = "󠁺", color = "#ce422b", name = "Rust" },
        go = { icon = "", color = "#00aed8", name = "Go" },
        c = { icon = "", color = "#555555", name = "C" },
        cpp = { icon = "", color = "#00599c", name = "C++" },
      },
      color_icons = true,
      default = true,
    })
    
    -- Warn if Nerd font is not detected
    local function warn_nerd_font()
      if not has_nerd_font() then
        vim.schedule(function()
          vim.notify(
            "⚠️  No Nerd Font detected! Icons may not display correctly.\n" ..
            "Please install a Nerd Font and set it in your terminal/editor.\n" ..
            "Popular options: JetBrains Mono Nerd, FiraCode Nerd, Hack Nerd",
            vim.log.levels.WARN,
            { title = "Nerd Font Warning", timeout = 5000 }
          )
        end)
      end
    end
    
    -- Defer the check to let terminal detect font
    vim.defer_fn(warn_nerd_font, 500)
  end,
}

