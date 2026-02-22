local nv = require "nvchad.configs.lspconfig"
local on_attach = nv.on_attach
local on_init = nv.on_init
local capabilities = nv.capabilities

local lspconfig = require "lspconfig"

-- helper biar gak error kalau server belum ada
local function setup_if_available(server, opts)
  if lspconfig[server] then
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }, opts or {}))
  end
end

lspconfig.vtsls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    typescript = {
      preferences = { importModuleSpecifier = "non-relative" },
      suggest = { completeFunctionCalls = true },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      procMacro = { enable = true },
      check = { command = "clippy" },
    },
  },
}

lspconfig.hls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "haskell", "lhaskell", "cabal" },
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
      plugin = {
        hlint = { globalOn = true },
      },
    },
  },
}

lspconfig.pbls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "proto" },
  -- pbls biasanya happy dengan root .git;
  -- kalau kamu pakai Buf workspace, ini juga oke:
  root_dir = require("lspconfig").util.root_pattern("buf.yaml", "buf.gen.yaml", ".git"),
  settings = {
    pbls = {
      diagnostics = { enable = true },
      completion = { enable = true },
      -- kalau perlu include_paths custom, bisa:
      -- includePaths = { "proto", "third_party" },
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
}

lspconfig.pyright.setup { on_attach = on_attach, on_init = on_init, capabilities = capabilities }

lspconfig.clangd.setup { on_attach = on_attach, on_init = on_init, capabilities = capabilities }
-- macOS brew path (opsional):
-- lspconfig.clangd.setup { cmd = { "/opt/homebrew/opt/llvm/bin/clangd" }, on_attach = on_attach, on_init = on_init, capabilities = capabilities }

lspconfig.sqls.setup { on_attach = on_attach, on_init = on_init, capabilities = capabilities }

setup_if_available "html"
setup_if_available "cssls"
setup_if_available "jsonls"
setup_if_available "yamlls"
setup_if_available "bashls"

setup_if_available "tailwindcss"

setup_if_available "dockerls"
setup_if_available "docker_compose_language_service"
setup_if_available "nginx_language_server"
setup_if_available "neocmake"
setup_if_available "lemminx"

setup_if_available("emmet_ls", {
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
  },
  init_options = {
    html = { options = { ["bem.enabled"] = true } },
  },
})

setup_if_available "asm_lsp"
