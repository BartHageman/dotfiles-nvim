local set = vim.opt

set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.number = true
set.relativenumber = true
set.laststatus = 3
set.clipboard = { "unnamedplus" } --slow? why?
set.scrolloff = 99
vim.opt.undofile = true
vim.opt.swapfile = false
set.wrap = false
set.ignorecase = true
set.smartcase = true
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = ""
set.foldlevel = 99
set.foldlevelstart = 99
set.foldenable = true

set.fillchars:append({
  eob = "·",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
  end,
})
vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
