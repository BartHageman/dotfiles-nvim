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

