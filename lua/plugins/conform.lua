return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua         = { "stylua" },
        python      = { "black" },
        javascript  = { "prettier" },
        typescript  = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        tsx         = { "prettier" },
        html        = { "prettier" },
        css         = { "prettier" },
        scss        = { "prettier" },
        json        = { "prettier" },
        yaml        = { "prettier" },
        markdown    = { "prettier" },
        graphql     = { "prettier" },
        sql         = { "sql_formatter" },
        c           = { "clang_format" },
        cpp         = { "clang_format" },
        java        = { "google_java_format" },
        rust        = { "rustfmt" },
        sh          = { "shfmt" },
      },
    })
    
  end,
}


