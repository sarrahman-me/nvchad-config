return {
  -- Formatter satu pintu (on save)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- LSP core + override konfigurasi kamu
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Pastikan server LSP penting terpasang via Mason
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "html",
        "rust_analyzer",
        "pyright",
        "tailwindcss",
        "sqls",
        "clangd",
        "eslint",
        "jsonls",
        "bashls",
        "cssls",
        "dockerls",
        "yamlls",
        "lua_ls",
        "emmet_ls",
        "asm_lsp",
        "docker_compose_language_service",
        "nginx_language_server",
        "neocmake",
        "lemminx",
        "hls",
        "pbls",
      },
      automatic_installation = false,
    },
  },

  -- Linter & code actions (eslint_d) – tanpa tumpang tindih dengan Conform
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    config = function()
      local null_ls = require "null-ls"
      local extras = require "none-ls.extras"
      null_ls.setup {
        sources = {
          extras.diagnostics.eslint_d,
          extras.code_actions.eslint_d,
          -- contoh tambahan (opsional):
          -- null_ls.builtins.diagnostics.shellcheck,
          -- null_ls.builtins.diagnostics.hadolint,
        },
      }
    end,
  },

  -- QoL kecil
  { "windwp/nvim-ts-autotag", event = "VeryLazy", opts = {} },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },

  -- Syntax highlighting yang lebih canggih berdasarkan AST
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "haskell",
        "proto",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local status, ts_configs = pcall(require, "nvim-treesitter.configs")
      if status then
        ts_configs.setup(opts)
      else
        local status2, ts = pcall(require, "nvim-treesitter")
        if status2 then
          ts.setup(opts)
        end
      end
    end,
  },
}
