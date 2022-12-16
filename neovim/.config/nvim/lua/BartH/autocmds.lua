local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({higroup="DiffAdd"})
  end,
  group = highlight_group,
  pattern = '*',
})


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
