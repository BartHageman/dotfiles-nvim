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
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevel = 99

set.fillchars:append({ eob = "·" })
