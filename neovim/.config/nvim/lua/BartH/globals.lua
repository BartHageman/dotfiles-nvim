path_separator = "/"
is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
if is_windows == true then
  path_separator = "\\"
end
