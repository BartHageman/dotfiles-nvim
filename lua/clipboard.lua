local _wl_paste_count = 0
local _clipboard_cache = { ["+"] = { value = { "" }, time = 0 }, ["*"] = { value = { "" }, time = 0 } }

local function wl_paste(primary)
  local reg = primary and "*" or "+"
  local now = vim.fn.reltimestr(vim.fn.reltime())

  if _clipboard_cache[reg].time > 0 and (tonumber(now) - tonumber(_clipboard_cache[reg].time)) < 0.1 then
    return _clipboard_cache[reg].value
  end

  _wl_paste_count = _wl_paste_count + 1
  local info = string.format(
    "[%d] %s mode=%s reg=%s caller=%s\n",
    _wl_paste_count,
    os.date("%H:%M:%S"),
    vim.api.nvim_get_mode().mode,
    primary and "*" or "+",
    debug.traceback("", 2):gsub("\n", " | ")
  )
  pcall(function()
    local f = io.open("/tmp/wlpaste.log", "a"); if f then f:write(info); f:close() end
  end)
  local args = primary and { "wl-paste", "--no-newline", "--primary" }
                       or { "wl-paste", "--no-newline" }
  local ok, res = pcall(function()
    return vim.system(args, { text = true }):wait(200)
  end)
  local result = (not ok or not res or res.code ~= 0 or not res.stdout) and { "" } or vim.split(res.stdout, "\n", { plain = true })
  _clipboard_cache[reg] = { value = result, time = tonumber(now) }
  return result
end

return {
  name = "wl-clipboard-cached",
  copy = {
    ["+"] = { "wl-copy", "--type", "text/plain" },
    ["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
  },
  paste = {
    ["+"] = function() return wl_paste(false) end,
    ["*"] = function() return wl_paste(true) end,
  },
  cache_enabled = 1,
}
