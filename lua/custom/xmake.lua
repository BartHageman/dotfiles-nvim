local function strip_ansi_and_split(str)
  -- First strip ANSI sequences
  local cleaned = str:gsub('\27%[[%d;]*%a', ''):gsub('%c', '')

  -- Split into lines, handling different newline types
  -- This creates a table where each element is a cleaned line
  local lines = {}
  for line in cleaned:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  return lines
end

local xmake_lua_found = vim.fn.filereadable(vim.fs.joinpath(vim.fn.getcwd(), 'xmake.lua')) == 1

if not xmake_lua_found then
  vim.api.nvim_notify("WARN: Unable to find xmake.lua file. Is it in the current working directory?",
    vim.log.levels
    .WARN, {})
  return
end

local result = vim.system({ 'xmake.exe', 'show', '-l', 'targets' }, { cwd = vim.fn.getcwd(), text = true }):wait()
print(vim.inspect(result))


local targets = strip_ansi_and_split(result.stdout)

if #targets == 0 then
  vim.api.nvim_err_writeln("Unable to find targets")
  return
end

vim.ui.select(targets, {
  prompt = 'Which target would you like to build?',
  format_item = function(item)
    return item
  end,
}, function(choice)
  require('custom.float_win').create_terminal({ title = "xmake build", cmd = "xmake.exe build " .. choice })
end)
