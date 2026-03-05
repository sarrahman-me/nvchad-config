return {
  -- Formatter satu pintu (on save)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function()
      return require "custom.configs.conform"
    end,
  },

  -- LSP core + override konfigurasi kamu
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.lspconfig"
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
        "vtsls", -- modern typescript server
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
      },
      automatic_installation = true,
    },
  },

  -- Tool installer untuk non-LSP (formatter/linter)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "stylua",
        "prettierd",
        "prettier",
        "black",
        "rustfmt",
        "shfmt",
        "sql-formatter",
        "eslint_d",
        "hadolint",
        "shellcheck",
        "clang-format",
      },
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
        "bash", "c", "cpp", "cmake", "css", "dockerfile", "go", "html",
        "javascript", "json", "lua", "markdown", "markdown_inline",
        "nginx", "python", "rust", "sql", "tsx", "typescript", "vim",
        "vimdoc", "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- Di Neovim 0.11, kita coba setup secara manual tanpa bergantung pada modul configs jika tidak ada
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if status then
        configs.setup(opts)
      else
        -- Fallback: Jika module hilang, kita tetap aktifkan highlight secara native
        vim.api.nvim_command("TSUpdate")
      end
    end,
  },
}
