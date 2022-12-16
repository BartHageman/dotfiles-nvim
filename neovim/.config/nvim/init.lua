local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
  packer_bootstrap = true 
end

if packer_bootstrap then
       require('packer').sync()
   else
end
local util = require('util')

if vim.g.neovide then
    local isWindows = vim.loop.os_uname().version:match "Windows"
    if isWindows then 
        vim.g.neovide_refresh_rate=160

    else vim.g.neovide_refresh_rate=60
    end
    vim.g.neovide_cursor_trail_length=0.001
    vim.g.neovide_cursor_animation_length=0.023
    vim.g.neovide_input_use_logo=true
end

vim.cmd([[
if exists("g:neovide")
    set guifont=Iosevka:h13
endif
]])

vim.env.VIMHOMEDIR = util.get_config_dir()
require('settings'):setup()
require('colorscheme').setup()
require('plugins')
require('loadcore')
-- require'keymappings').config()
-- require('keymappings').setup()
