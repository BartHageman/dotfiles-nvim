local set = vim.opt

set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.number = true
set.relativenumber = true
set.laststatus = 3
set.clipboard = { "unnamedplus" } --slow? why?
set.scrolloff = 10
vim.opt.undofile = true
set.wrap = false
set.ignorecase = true
set.smartcase = true

set.fillchars:append({ eob = "·" })
