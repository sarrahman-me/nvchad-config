-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("n", "<leader>cc", function()
  require("CopilotChat").toggle()
end, { desc = "Copilot Chat" })
vim.keymap.set("v", "<leader>ce", function()
  require("CopilotChat").ask "Refactor sesuai style proyek; jelaskan alasannya."
end, { desc = "Copilot Chat edit selection" })
