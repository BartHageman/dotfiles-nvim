-- TODO: fix up buffers like telescope

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function() vim.cmd("wincmd L") end,
})

-- vim.api.nvim_create_autocmd({"InsertEnter"}, {
--   group = "InsertRelative",
--   callback = function()
--     vim.opt.relativenumber = false
--   end
-- })
--
--
-- vim.api.nvim_create_autocmd({"InsertLeave"}, {
--   group = "InsertRelative",
--   callback = function()
--     vim.opt.relativenumber = true
--   end
-- })
