vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Silence all deprecation warnings (LSP, etc) for Neovim 0.11
vim.env.NVIM_LSPCONFIG_NO_DEPRECATE = "1"
vim.g.deprecation_warnings = false
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Matikan warning dari core nvim
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("deprecated") or msg:match("deprecate") then
    return
  end
  notify(msg, ...)
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- setup chadrc
vim.g.nvchad_config = "custom.chadrc"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "custom.plugins" },
}, lazy_config)

-- load theme
pcall(function()
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
end)

require "nvchad.options"
require "custom.options"
require "custom.autocmds"

vim.schedule(function()
  pcall(require, "nvchad.mappings")
  require "custom.mappings"
end)
