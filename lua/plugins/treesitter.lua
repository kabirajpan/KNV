return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        -- Programming Languages
        "bash", "c", "cpp", "java", "python", "lua", "rust", "go",
        "javascript", "typescript", "tsx", "jsdoc",

        -- Markup / Styles
        "html", "css", "scss", "json", "yaml", "toml", "markdown", "markdown_inline",

        -- DevOps / Configs
        "dockerfile", "gitignore", "make", "cmake",

        -- DB / Graph
        "sql", "graphql",

        -- Misc
        "vim", "regex", "query", "asm"
      },

      auto_install = true,  -- Auto-install missing parsers when entering buffer

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      autotag = {
        enable = true,  -- For html/jsx/tsx auto-close tags
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
    }
  end,
}

