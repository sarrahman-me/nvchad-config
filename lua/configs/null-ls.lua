local null_ls = require "null-ls"
local extras = require "none-ls.extras"

null_ls.setup {
  sources = {
    extras.diagnostics.eslint_d,
    extras.code_actions.eslint_d,
  },
}
