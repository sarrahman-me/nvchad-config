local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },

    python = { "black" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    sql = { "sql-formatter" },
    sh = { "shfmt" },
  },

  -- Format otomatis setiap save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true, -- kalau formatter nggak ada, fallback ke LSP
  },
}

return options
