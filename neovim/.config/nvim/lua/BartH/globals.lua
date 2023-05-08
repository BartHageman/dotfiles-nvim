path_separator = "/"
is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
if is_windows == true then
  path_separator = "\\"
end

local torchit = function()
    vim.cmd[[
        set shada=!,'0,<50,s10,h
        wsh!
    ]]
    vim.cmd("qa!")
end
vim.api.nvim_create_user_command("TorchIt", torchit, {})

local runEJS = function()
   local cmd = "cd " .. vim.fn.expand('%:p:h') .. ";npx ejs ./index.ejs -f ../__tests__/data/ejstestdata.json -o ./index.html"
   print(cmd)
   vim.fn.jobstart(cmd, {stdout_buffered = true})
end

vim.api.nvim_create_user_command("RunEJS", runEJS, {})
vim.g.wordmotion_prefix = '<leader>'

vim.cmd[[
    let b:match_ignorecase = 1
    let b:match_words = '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
    \ . '\<while\>:\<endwhile\>,' . '\<group\>:\<endgroup\>,' . '\<state\>:\<endstate\>,\<function\>:\<endfunction\>,\<struct\>:\<endstruct\>,\<event\>:\<endevent\>' 
]]
-- vim.cmd[[
-- function! SynStack()
--   if !exists("*synstack")
--     return
--   endif
--   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
-- endfunc
--
-- nnoremap <leader>scs <cmd>call SynStack()<cr>
-- ]]
