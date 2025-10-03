return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",

    -- Completion sources
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    
    -- AI assistants
    "zbirenbaum/copilot-cmp",
    "Exafunction/codeium.nvim",
    
    -- Icons
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Custom snippets setup
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        -- Select the [n]ext item
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        -- Accept completion
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        
        -- Enhanced Tab behavior that works with AI suggestions
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- Priority order: cmp completion -> snippet jump -> AI suggestions -> fallback
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Manually trigger completion
        ["<C-Space>"] = cmp.mapping.complete({}),

        -- Scroll documentation
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        
        -- Dismiss completion menu
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      
      -- IMPORTANT: Source priority order
      sources = cmp.config.sources({
        -- AI assistants get highest priority
        { name = "copilot", priority = 1000, max_item_count = 3 },
        { name = "codeium", priority = 900, max_item_count = 3 },
        
        -- Core completion sources
        { name = "nvim_lsp", priority = 800, max_item_count = 20 },
        { name = "luasnip", priority = 700, max_item_count = 5 },
        
        -- Fallback sources
        { name = "buffer", priority = 500, max_item_count = 5 },
        { name = "path", priority = 300, max_item_count = 10 },
      }),
      
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
          symbol_map = {
            Copilot = "",
            Codeium = "󰘦",
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          },
          before = function(entry, vim_item)
            -- Add source name to the completion item
            vim_item.menu = ({
              copilot = "[Copilot]",
              codeium = "[Codeium]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            
            return vim_item
          end,
        }),
      },
      
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:CmpDoc",
        }),
      },
      
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      
      -- Performance tuning
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        async_budget = 1,
        max_view_entries = 200,
      },
    })

    -- Command line completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
    
    -- Custom highlight groups for better AI suggestion visibility
    vim.cmd([[
  " Copilot ghost text: Orange
  highlight! CmpItemKindCopilot guifg=#FFA500 gui=italic

  " Codeium ghost text: Blue
  highlight! CmpItemKindCodeium guifg=#00BFFF gui=italic

  " General ghost text fallback (if source is not detected)
  highlight! CmpGhostText guifg=#00BFFF gui=italic
]])
  end,
}
