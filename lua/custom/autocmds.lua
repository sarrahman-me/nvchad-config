require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Enable inlay hints by default for Neovim 0.10+
autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Format on save (optional override if conform is not enough)
-- autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
--   end,
-- })
