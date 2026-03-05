local nv = require "nvchad.configs.lspconfig"
local on_attach = nv.on_attach
local on_init = nv.on_init
local capabilities = nv.capabilities

-- Silent any LSP deprecation warnings
vim.env.NVIM_LSPCONFIG_NO_DEPRECATE = "1"

local configs = require "lspconfig.configs"

-- Konfigurasi default
local default_config = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- List server yang ingin di-setup secara manual dengan opsi khusus
local manual_servers = {
  vtsls = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "all" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
    },
  },
  tailwindcss = {
    filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
  },
  eslint = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        check = { command = "clippy" },
        inlayHints = { enable = true },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        hint = { enable = true },
      },
    },
  },
  pyright = {},
  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  },
}

-- Server lainnya (Setup otomatis tanpa opsi tambahan)
local other_servers = {
  "html",
  "cssls",
  "jsonls",
  "sqls",
  "yamlls",
  "bashls",
  "dockerls",
  "docker_compose_language_service",
  "nginx_language_server",
  "neocmake",
  "emmet_ls",
}

-- Jalankan setup untuk server manual
for name, opts in pairs(manual_servers) do
  if configs[name] then
    configs[name].setup(vim.tbl_deep_extend("force", default_config, opts))
  end
end

-- Jalankan setup untuk server lainnya
for _, name in ipairs(other_servers) do
  if configs[name] then
    configs[name].setup(default_config)
  end
end
