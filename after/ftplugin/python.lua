local tt = require("custom.float_win")
vim.keymap.set({ 'n', 't' }, "<leader>tr", function()
  tt.toggle_terminal { title = "Python Run", cmd = "python " .. vim.fn.expand('%') }
end)
