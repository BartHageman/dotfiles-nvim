local M = {}

function M.join_paths(...)
  local uv = vim.loop
  local path_sep = (vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1) and "\\" or "/"
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
return M
