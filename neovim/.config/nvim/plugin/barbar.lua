vim.keymap.set("n", "<leader>.", "<cmd>BufferNext<CR>")
vim.keymap.set("n", "<leader>,", "<cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<leader><", "<cmd>BufferMovePrevious<CR>")
vim.keymap.set("n", "<leader>>", "<cmd>BufferMoveNext<CR>")

for i = 1,9 do
    vim.keymap.set("n", "<A-" .. i .. ">", "<cmd>BufferGoto " .. i .. "<CR>")
end
vim.keymap.set("n", "<A-" .. 0 .. ">", "<cmd>BufferGoto " .. 10 .. "<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>BufferClose<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>")
