local luasnip = require("luasnip")
vim.keymap.set('n', '<leader>cd', '<CMD>cd %:p:h<CR><CMD>pwd<CR>', {})
vim.keymap.set('n', '<cr>', 'o<esc>', {})
vim.keymap.set('n', '<S-Enter>', 'O<esc>', {})

-- Make Y behave like the rest of the capital letters
vim.keymap.set('n', 'Y', 'y$', {})

-- Pasting over something in visual mode no longer overwrites what you copied.
vim.keymap.set('x', '<leader>p', '"_dP', {})

-- Keep screen centered when jumping and concatenating lines
vim.keymap.set('n', 'n', 'nzzzv', {})
vim.keymap.set('n', 'N', 'Nzzzv', {})
vim.keymap.set('n', 'J', 'mzJ`z', {})

-- --Digraph menu
-- vim.keymap.set({ 'i', 's' }, "<c-y>", "<c-k>") -- Free up ctrl-k for luasnip and assign ctrl-y to the digraph menu

-- Open Terminal in new tab
vim.keymap.set('n', '<leader>ot', '<cmd>tabnew<CR><cmd>term<CR>i', {})


vim.keymap.set('n', '<leader>rn', ':%s/<C-r><C-W>/', {})
-- ------------
-- LUASNIP
-- ------------
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
-- ----------------
-- TELESCOPE
-- ----------------
vim.keymap.set("n", "<leader><leader>s", "<cmd>source $VIMHOMEDIR/plugin/luasnip.lua<CR>")

vim.keymap.set("n", "E", "ge")
vim.keymap.set("n", "<leader>tz", "<cmd>TZAtaraxis<CR>")
-- CamelCaseMotion
--
vim.g.camelcasemotion_key = '<leader>'
local modes = {"n", "o", "v"}
local motions = { "w", "b", "e", "ge" }
local keys = {"w", "b", "e", "E" }
for i=1,3 do
    for j=1,4 do
        vim.keymap.set(modes[i], "<leader>" .. keys[j], "<Plug>CamelCaseMotion_" .. motions[j], {silent=true})
    end
end

modes = {"o", "x"}
for i=1,2 do
    for j=1,4 do
        vim.keymap.set(modes[i], "<leader>" .. keys[j], "<Plug>CamelCaseMotion_i" .. motions[j], {silent=true})
    end
end
-- vim.keymap.set("n", "<leader>b", " <Plug>CamelCaseMotion_b", {silent=true})
-- vim.keymap.set("n", "<leader>e", " <Plug>CamelCaseMotion_e", {silent=true})
-- vim.keymap.set("n", "<leader>E", " <Plug>CamelCaseMotion_ge", {silent=true})
-- vim.keymap.set("n", "<leader>E", " <Plug>CamelCaseMotion_ge", {silent=true})
-- vim.keymap.set("n", "<leader>iw", " <Plug>CamelCaseMotion_iw", {silent=true})
-- vim.keymap.set("n", "<leader>ib", " <Plug>CamelCaseMotion_ib", {silent=true})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>gf", require('telescope.builtin').git_files)
vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers)
vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
vim.keymap.set("n", "<leader>fr", require('telescope.builtin').oldfiles)
vim.keymap.set("n", "<leader>f/", require('core.telescope').grep_current_file)
vim.keymap.set("n", "<leader>vrc", require('core.telescope').search_dotfiles)
vim.keymap.set("n", "<leader>gww", require('telescope').extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<leader>gwc", require('telescope').extensions.git_worktree.create_git_worktree)
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
