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
    -- sql = { "sql-formatter" },
    sh = { "shfmt" },
    proto = { "buf" },
    haskell = { "fourmolu", "ormolu", "stylish_haskell" },
  },

  -- Format otomatis setiap save
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "sql" then
      return nil -- no auto-format for SQL
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

return options
