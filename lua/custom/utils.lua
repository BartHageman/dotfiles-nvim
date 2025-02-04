local M = {}

M.PartialApplication = function(func, defaults)
  local final_func = function(opts)
    local final_opts = vim.tbl_deep_extend('force', defaults, opts or {})
    func(final_opts)
  end
  return final_func
end

return M
