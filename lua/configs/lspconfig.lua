local lspconfig = require "lspconfig"
local nv = require "nvchad.configs.lspconfig"
local caps = nv.capabilities

-- helper biar gak error kalau server belum ada
local function setup_if_available(server, opts)
  if lspconfig[server] then
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
      on_attach = nv.on_attach,
      on_init = nv.on_init,
      capabilities = caps,
    }, opts or {}))
  end
end

lspconfig.vtsls.setup {
  on_attach = nv.on_attach,
  on_init = nv.on_init,
  capabilities = caps,
  settings = {
    typescript = {
      preferences = { importModuleSpecifier = "non-relative" },
      suggest = { completeFunctionCalls = true },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = nv.on_attach,
  on_init = nv.on_init,
  capabilities = caps,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      procMacro = { enable = true },
      check = { command = "clippy" },
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = nv.on_attach,
  on_init = nv.on_init,
  capabilities = caps,
  settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
}

lspconfig.pyright.setup { on_attach = nv.on_attach, on_init = nv.on_init, capabilities = caps }

lspconfig.clangd.setup { on_attach = nv.on_attach, on_init = nv.on_init, capabilities = caps }
-- macOS brew path (opsional):
-- lspconfig.clangd.setup { cmd = { "/opt/homebrew/opt/llvm/bin/clangd" }, on_attach = nv.on_attach, on_init = nv.on_init, capabilities = caps }

lspconfig.sqls.setup { on_attach = nv.on_attach, on_init = nv.on_init, capabilities = caps }

-- ==== Tambahan supaya server lain aktif ====
setup_if_available "html"
setup_if_available "cssls"
setup_if_available "jsonls"
setup_if_available "yamlls"
setup_if_available "bashls"

setup_if_available("tailwindcss", {
  -- root_dir dll default sudah oke; tambahkan settings bila perlu
})

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
-- NOTE: eslint-lsp sengaja TIDAK di-setup karena kamu sudah pakai eslint_d via none-ls
