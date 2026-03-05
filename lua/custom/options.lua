-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Map common unknown filetypes for LSP
vim.filetype.add {
  extension = {
    jsx = "javascriptreact",
    tsx = "typescriptreact",
    conf = "nginx",
  },
  pattern = {
    ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"] = "yaml.docker-compose",
  },
}
