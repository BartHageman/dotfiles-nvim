local map = vim.keymap.set
local let = vim.g
-- local set = vim.opt

let.mapleader = ' '

-- Go to the first non-blank character of 
-- EITHER 
-- the starting line of the paragraph 
-- OR
-- ending line of the paragraph
map({'n', 'x'}, '<leader>{', '{j_', {}) -- Starting line
map({'n', 'x'}, '<leader>}', '}k_', {}) -- Ending line

-- Easily void things you're visually pasting over
map('x', '<leader>p', '"_dP', {})

-- Keep screen centered when moving around
map('n', 'n', 'nzz', {})
map('n', 'N', 'Nzz', {})
map('n', '<C-d>', '<C-d>zz', {})
map('n', '<C-u>', '<C-u>zz', {})
map('n', 'N', 'Nzz', {})

map('n', 'J', 'mzJ`z', {})

-- Add aditional undo moments for punctuation marks
map('i', ',', ',<c-g>u')
map('i', '?', '?<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')

-- Move things around easily by holding alt
-- vmap('<M-j>', ":m '>+1<CR>gv=gv")
-- vmap('<M-k>', ":m '<-2<CR>gv=gv")
-- imap('<M-j>', '<esc>:m .+1<CR>==')
-- imap('<M-k>', '<esc>:m .-2<CR>==')
-- nmap('<M-j>', ':m .+1<CR>==')
-- nmap('<M-k>', ':m .-2<CR>==')

-- Make visual indentation not stupid
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Quickfix list
map('n', '[q', '<cmd>cp<cr>', { desc = "Previous [Q]uickfix list item" })
map('n', ']q', '<cmd>cn<cr>', { desc = "Next [Q]uickfix list item" })
map('n', '<leader>qo', ':copen<cr>')
map('n', '<leader>qc', ':copen<cr>')

vim.keymap.set('n', '<leader>cd', '<CMD>cd %:p:h<CR><CMD>pwd<CR>',
  { desc = '[C]hange working [D]irectory to current file parent' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- map("n", "<C-j>", ":cnext<cr>")
-- map("n", "<C-k>", ":cprev<cr>")
--
-- Code actions
-- TODO: move this to lsp
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>gD", vim.lsp.buf.declaration)
map("n", "<leader>gd", vim.lsp.buf.definition)
map("n", "<leader>gd", vim.lsp.buf.implementation)
map("n", "<leader>gr", vim.lsp.buf.references)
map("n", "<leader>gf", vim.lsp.buf.format)

-- -- Easier terminal escape
map("t", "<esc><esc>", '<C-\\><C-N>')

-- -- Make sure we can paste from the clipboard in insert mode
-- -- This overwrites <C-v> which is used to write bytes directly by typing numbers
-- -- Pretty sure I'll never use that.
-- map("i", "<C-v>", '<C-R>+')

vim.keymap.set("n", "<leader>th", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)

vim.keymap.set("n", "<leader>tf", require('custom.float_win').create_terminal)



-- Always switch to newly created splits

vim.keymap.set("n", "<C-w>s", "<C-w>s<C-w>j")
vim.keymap.set("n", "<C-w>v", "<C-w>v<C-w>l")

