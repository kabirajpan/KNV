-- lua/plugins/lsp.lua
-- Updated LSP configuration for Neovim 0.11+ (vim.lsp.config API)

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      config = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        -- This will be configured in the main config function below
      end,
    },
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      -- Key mappings
      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      -- Flutter/Dart specific keymaps
      if client.name == "dartls" then
        nmap("<leader>fd", ":FlutterDevices<CR>", "[F]lutter [D]evices")
        nmap("<leader>fe", ":FlutterEmulators<CR>", "[F]lutter [E]mulators")
        nmap("<leader>fr", ":FlutterRun<CR>", "[F]lutter [R]un")
        nmap("<leader>fq", ":FlutterQuit<CR>", "[F]lutter [Q]uit")
        nmap("<leader>fh", ":FlutterHotReload<CR>", "[F]lutter [H]ot Reload")
        nmap("<leader>fR", ":FlutterHotRestart<CR>", "[F]lutter Hot [R]estart")
      end

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local mason_lspconfig = require("mason-lspconfig")

    -- Server-specific configurations using NEW vim.lsp.config API
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      },
      
      ts_ls = {
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
      
      html = {
        filetypes = { "html", "twig", "hbs", "astro" },
      },
      
      cssls = {
        filetypes = { "css", "scss", "less" },
      },
      
      emmet_ls = {
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "svelte",
          "astro",
        },
      },
      
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "svelte",
          "astro",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- UnoCSS support
                { "uno-['\"`]([^'\"`]*)['\"`]", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      },

      -- UnoCSS LSP (if available)
      unocss = {
        filetypes = {
          "html",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
        },
      },

      -- Astro
      astro = {
        filetypes = { "astro" },
      },
      
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      },

      -- Dart/Flutter LSP configuration
      dartls = {
        settings = {
          dart = {
            analysisExcludedFolders = {
              vim.fn.expand("~/.pub-cache"),
              vim.fn.expand("/opt/homebrew"),
              vim.fn.expand("$HOME/fvm"),
            },
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            showTodos = true,
            lineLength = 120,
            enableSdkFormatter = true,
          },
        },
      },
    }

    -- Setup mason-lspconfig
    mason_lspconfig.setup({
      ensure_installed = {
        -- Modern Web Stack
        "ts_ls",           -- TypeScript/JavaScript
        "html",            -- HTML
        "cssls",           -- CSS
        "tailwindcss",     -- Tailwind/UnoCSS
        "eslint",          -- ESLint
        "emmet_ls",        -- Emmet
        "astro",           -- Astro

        -- Python
        "pyright",

        -- Lua
        "lua_ls",

        -- C/C++
        "clangd",

        -- Java
        "jdtls",

        -- Rust
        "rust_analyzer",

        -- Dart/Flutter
        "dartls",

        -- SQL
        "sqls",

        -- JSON/YAML/Markdown
        "jsonls",
        "yamlls",
        "marksman",

        -- Bash/Docker/Git/Go
        "bashls",
        "dockerls",
        "gopls",

        -- Optional extras
        "lemminx",     -- XML
        "taplo",       -- TOML
      },
      automatic_installation = true,
    })

    -- NEW API: Configure servers using vim.lsp.config
    for server_name, config in pairs(servers) do
      local server_config = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach,
      }, config)

      -- Use the new vim.lsp.config API if available (Neovim 0.11+)
      if vim.lsp.config then
        vim.lsp.config[server_name] = server_config
      else
        -- Fallback to old API for older Neovim versions
        require("lspconfig")[server_name].setup(server_config)
      end
    end

    -- Enable configured servers
    if vim.lsp.enable then
      for server_name, _ in pairs(servers) do
        vim.lsp.enable(server_name)
      end
    end

    -- Setup servers that aren't in the servers table with default config
    local installed_servers = mason_lspconfig.get_installed_servers()
    for _, server_name in pairs(installed_servers) do
      if not servers[server_name] then
        local default_config = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        if vim.lsp.config then
          vim.lsp.config[server_name] = default_config
          vim.lsp.enable(server_name)
        else
          require("lspconfig")[server_name].setup(default_config)
        end
      end
    end

    -- Configure diagnostic signs
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
      update_in_insert = false,
      float = {
        source = "always",
      },
    })
  end,
}
