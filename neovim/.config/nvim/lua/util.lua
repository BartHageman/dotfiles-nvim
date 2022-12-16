local M = {}
-- It's not safe to require 'utils' without adjusting the runtimepath
function M.join_paths(...)
  local uv = vim.loop
  local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

function M.get_runtime_dir()
    return vim.fn.stdpath "config"
end

function M.get_config_dir()
    return vim.fn.stdpath "config"
end

function M.get_cache_dir()
    return vim.fn.stdpath "cache"
end

function M:init()
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_path = get_cache_dir()

  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.packer_install_dir = join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
  self.packer_cache_path = join_paths(self.config_dir, "plugin", "packer_compiled.lua")

-- local config = require "config"
-- config:init {
--   path = join_paths(self.config_dir, "config.lua"),
-- }
--
-- require("plugin-loader"):init {
--   package_root = self.pack_dir,
--   install_path = self.packer_install_dir,
-- }
--
return self
end

return M
