local map = vim.keymap.set
local let = vim.g
-- local set = vim.opt

let.mapleader = ' '

-- Forward motion - goes to last non-blank line before next blank
vim.keymap.set({ 'n', 'v', 'o' }, 'g}', function()
  local current_col = vim.fn.col('.')
  -- Find next blank line
  vim.fn.search('^\\s*$', 'W')
  -- Move up one to the last non-blank
  if vim.fn.line('.') > 1 then
    vim.cmd('normal! k')
  end
  vim.fn.cursor(vim.fn.line('.'), current_col)
end)

-- Backward motion - goes to first non-blank line after previous blank
vim.keymap.set({ 'n', 'v', 'o' }, 'g{', function()
  local current_col = vim.fn.col('.')
  -- Find previous blank line
  vim.fn.search('^\\s*$', 'bW')
  -- Move down one to the first non-blank
  if vim.fn.line('.') < vim.fn.line('$') then
    vim.cmd('normal! j')
  end
  vim.fn.cursor(vim.fn.line('.'), current_col)
end)

-- map({ 'n', 'x' }, '<leader>{', '{j_', {}) -- Starting line
-- map({ 'n', 'x' }, '<leader>}', '}k_', {}) -- Ending line a
--
--
-- vim.keymap.set({ 'n', 'x', 'v' }, 'g}', move_to_last_non_blank_in_block,
--   { desc = 'Move to last non-blank line in block' })
-- vim.keymap.set({ 'n', 'x', 'v' }, 'g{', move_to_first_non_blank_in_block,
--   { desc = 'Move to first non-blank line in block' })
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
vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
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

map("n", "ca", vim.lsp.buf.code_action)
map("n", "gf", vim.lsp.buf.format)
map("n", "grn", vim.lsp.buf.rename)

map("n", "gD", ":lua vim.lsp.buf.declaration()<cr>zz")
map("n", "gd", ":lua vim.lsp.buf.definition()<cr>zz")
map("n", "gi", ":lua vim.lsp.buf.implementation()<cr>zz")
map("n", "gr", ":lua vim.lsp.buf.references()<cr>zz")

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

vim.keymap.set("n", "<leader>gxna", "gxiagxina")
vim.keymap.set("n", "<leader>gxpa", "gxiagxila")


-- Ungoof myself if I type something I didn't mean to.
vim.keymap.set("n", "q:", ":q")

-- Toggle quickfix list function
local function toggle_quickfix()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

vim.keymap.set("n", "tq", toggle_quickfix)
