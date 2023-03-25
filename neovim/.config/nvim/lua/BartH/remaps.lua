function nmap(lhs, rhs, opt)
   opt = opt or {}
   vim.keymap.set('n', lhs, rhs, opt)
end

function xmap(lhs, rhs, opt)
   opt = opt or {}
   vim.keymap.set('x', lhs, rhs, opt)
end

function vmap(lhs, rhs, opt)
   opt = opt or {}
   vim.keymap.set('v', lhs, rhs, opt)
end

function imap(lhs, rhs, opt)
   opt = opt or {}
   vim.keymap.set('i', lhs, rhs, opt)
end

vim.g.mapleader = " "
vim.g.camelcasemotion_key = '<leader>'

nmap("<leader>tt", "<cmd>Neotree toggle<CR>")

nmap("<leader>ff", require('telescope.builtin').find_files)
nmap("<leader>fws", require('telescope.builtin').lsp_workspace_symbols)
nmap("<leader>fds", require('telescope.builtin').lsp_document_symbols)
nmap("<leader>fdd", require('telescope.builtin').diagnostics)
nmap("<leader>gf", require('telescope.builtin').git_files)
nmap("<C-p>", require('telescope.builtin').git_files)
nmap("<leader>fg", require('telescope.builtin').live_grep)
nmap("<leader>fb", require('telescope.builtin').buffers)
nmap("<leader>fh", require('telescope.builtin').help_tags)
nmap("<leader>fr", require('telescope.builtin').oldfiles)
nmap("<leader>f/", require('telescope.builtin').current_buffer_fuzzy_find)
nmap("<leader>vrc", require('BartH.telescope').search_dotfiles)
nmap("<leader>gww", require('telescope').extensions.git_worktree.git_worktrees)
nmap("<leader>gwc", require('telescope').extensions.git_worktree.create_git_worktree)
nmap("<leader>gg", "<cmd>G<cr>")
nmap("<leader>gP", "<cmd>Git push<cr>")
nmap("<leader>gp", "<cmd>Git pull<cr>")


nmap("<leader>u", "<cmd>UndotreeToggle<cr>")

nmap('<leader>cd', '<CMD>cd %:p:h<CR><CMD>pwd<CR>', {})
-- Enter
nmap('<cr>', 'o<esc>', {})
nmap('<C-CR>', 'O<esc>', {})

-- Make Y behave like the rest of the capital letters
nmap('Y', 'yg$', {})

nmap("E", "ge")

-- Pasting over something in visual mode no longer overwrites what you copied.
xmap('<leader>p', '"_dP', {})

-- Keep screen centered when jumping and concatenating lines
nmap('n', 'nzzzv', {})
nmap('N', 'Nzzzv', {})
nmap('J', 'mzJ`z', {})


nmap("<leader>.", "<cmd>BufferNext<CR>")
nmap("<leader>,", "<cmd>BufferPrevious<CR>")
nmap("<leader><", "<cmd>BufferMovePrevious<CR>")
nmap("<leader>>", "<cmd>BufferMoveNext<CR>")

for i = 1,9 do
    nmap("<A-" .. i .. ">", function() require("harpoon.ui").navfile(i) end)
end
-- nmap("<A-" .. 0 .. ">", "<cmd>BufferGoto " .. 10 .. "<CR>")

nmap("<leader>tx", "<cmd>BufferClose<CR>")
nmap("<leader>tn", "<cmd>tabnew<CR>")

vmap("<M-j>", ":m '>+1<CR>gv=gv")
vmap("<M-k>", ":m '<-2<CR>gv=gv")
imap("<M-j>", "<esc>:m .+1<CR>==")
imap("<M-k>", "<esc>:m .-2<CR>==")
nmap("<M-j>", ":m .+1<CR>==")
nmap("<M-k>", ":m .-2<CR>==")

vim.keymap.set("t", "<esc>", "<C-\\><C-N>", {})

imap(",", ",<c-g>u")
imap("?", "?<c-g>u")
imap("!", "!<c-g>u")
imap(".", ".<c-g>u")

vim.cmd ([[
    nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
    nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
]])


nmap("<M-J>","<cmd>resize -2<CR>")
nmap("<M-K>","<cmd>resize +2<CR>")
nmap("<M-H>","<cmd>vertical resize -2<CR>")
nmap("<M-L>","<cmd>vertical resize +2<CR>")

vmap("<", "<gv")
vmap(">", ">gv")


-- Keep screen centered when jumping and concatenating lines
nmap('n', 'nzzzv', {})
nmap('N', 'Nzzzv', {})
nmap('J', 'mzJ`z', {})
nmap('<C-d>', '<C-d>zz', {})
nmap('<C-u>', '<C-u>zz', {})

-- nmap('q:', '<nop>')
nmap('Q', '<nop>')

nmap('<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')


nmap('<C-k>', '<cmd>cp<cr>')
nmap('<C-j>', '<cmd>cn<cr>')
nmap('<leader>tz', '<cmd>TZAtaraxis<cr>')



-- ===========
-- Luasnip
-- ===========
--
local luasnip = require('luasnip')
vim.keymap.set({ 'i', 's' }, "<c-k>", function() -- Expand snippet key
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, {silent = true})

vim.keymap.set({ 'i', 's' }, "<c-j>", function() -- go back in snippet key
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, {silent = true})


vim.keymap.set({ 'i', 's' }, "<c-l>", function() -- Change choice at snippet
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, {silent = true})


vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
require('leap').add_default_mappings()
