local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({higroup="DiffAdd"})
  end,
  group = highlight_group,
  pattern = '*',
})

local expandFold_group = vim.api.nvim_create_augroup('expandFold', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost,FileReadPost', {
  command = "normal zR",
  group = expandFold_group,
  pattern = '*',
})

local write_typescript = vim.api.nvim_create_augroup('typescript', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
        vim.lsp.buf.format({
              filter = function(client) return client.name ~= "tsserver" end
        }) -- For nvim 0.8
        --vim.lsp.buf.formatting()
    end,
  group = write_typescript,
  pattern = '*.ts'
})

-- Create thesaurus keybinds only when editing txt and md
local thesaurusKeybinds = vim.api.nvim_create_augroup('thesaurusKeybinds', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.keymap.set('n', "<leader>cs", "<CMD>ThesaurusQueryReplaceCurrentWord<CR>", {silent=true, buffer=true})
    vim.keymap.set('v', "<leader>cs", 'y:ThesaurusQueryReplace <C-r>"<CR>', {silent=true, buffer=true})
  end,
  group = thesaurusKeybinds,
  pattern = {'text', 'markdown', 'fountain'}
})
    -- autocmd FileType papyrus setlocal commentstring=;%s

local papyrus = vim.api.nvim_create_augroup('papyrus', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
        vim.bo.commentstring = ";%s"
        vim.wo.foldmethod = "indent"
        vim.cmd[[
            let b:match_ignorecase = 1
            let b:match_words = '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
            \ . '\<while\>:\<endwhile\>,' . '\<group\>:\<endgroup\>,' . '\<state\>:\<endstate\>,\<function\>:\<endfunction\>,\<struct\>:\<endstruct\>,\<event\>:\<endevent\>' 
        ]]
  end,
  group = papyrus,
  pattern = {"papyrus"}
})

local neorg = vim.api.nvim_create_augroup('norg', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
        vim.keymap.set("n", "<Tab>", "za", {buffer = true})
  end,
  group = neorg,
  pattern = {"norg"}
})
-- vim.api.nvim_create_autocmd('InsertLeave', {
--   command = "zx",
--   group = neorg,
--   pattern = {"norg"}
-- })

local restore_cursor = vim.api.nvim_create_augroup('restore_cursor', {clear = true})
-- vim.cmd[[autocmd BufRead * autocmd FileType <buffer> ++once
--   \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
vim.api.nvim_create_autocmd('BufRead', {
    callback = function()
        --local blockedFiles = vim.regex('commit\\|rebase\\|neo-tree\\|TelescopePrompt')
        --local blockedfiletype = blockedFiles:match_string(vim.bo.filetype)
        if (not blockedfiletype) and (vim.fn.line("'\"") > 1) and (vim.fn.line("'\"") <= vim.fn.line("$")) then
            vim.fn.execute('normal! g`"zz')
        end
    end,
    group = restore_cursor,
    pattern = "*"
})

vim.cmd([[au BufNewFile,BufRead *.ejs set filetype=html]])
