local id = vim.api.nvim_create_augroup("InsertRelative", {
    clear = true
})
vim.api.nvim_create_autocmd({"InsertEnter"}, {
  group = "InsertRelative",
  callback = function()
    vim.opt.relativenumber = false
  end
})


vim.api.nvim_create_autocmd({"InsertLeave"}, {
  group = "InsertRelative",
  callback = function()
    vim.opt.relativenumber = true
  end
})
