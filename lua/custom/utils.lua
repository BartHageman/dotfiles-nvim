local M = {}

M.PartialApplication = function(func, defaults)
  local final_func = function(opts)
    local final_opts = vim.tbl_deep_extend('force', defaults, opts or {})
    func(final_opts)
  end
  return final_func
end

M.PatternMatch = function(patterns, default)
  local p = function(query)
    local patterns_meta = {
      _index = default or function(key)
        vim.notify("Error: Pattern '" .. key .. "' could not be matched!")
      end
    }
    setmetatable(patterns, patterns_meta)
    return patterns[tostring(query)]
  end
  return p
end

local p = M.PatternMatch({ ["hello"] = function() print("hello world!") end })

print("dave")
p("dave")()
-- local patterns = { ["hello"] = function() print("hello world!") end }
-- print(vim.inspect(patterns))
-- print(vim.inspect(patterns["hello"]))

-- p("hello")
-- p("blah")


return M
