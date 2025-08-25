local M = {}

-- Default configuration with screen percentage calculations
local default_config = {
  width = 0.8,  -- Percentage of screen width
  height = 0.8, -- Percentage of screen height
}

local state = {}
local state_mt = {
  __index = function() return { buf = -1, win = -1 } end
}

-- Set a default metatable for terms that haven't been created yet.
setmetatable(state, state_mt)

-- Calculate the floating window dimensions and position
local function get_window_dimensions(config)
  local width = config.width or default_config.width
  local height = config.height or default_config.height

  -- Convert percentages to absolute values
  local vim_width = vim.api.nvim_get_option_value("columns", {})
  local vim_height = vim.api.nvim_get_option_value("lines", {})

  -- Calculate actual dimensions
  local win_width = math.floor(vim_width * (type(width) == "number" and width or 0.8))
  local win_height = math.floor(vim_height * (type(height) == "number" and height or 0.8))

  -- Calculate starting position for centering
  local row = math.floor((vim_height - win_height) / 2)
  local col = math.floor((vim_width - win_width) / 2)

  return {
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }
end

function M.create_terminal(config)
  config = config or {}

  -- Calculate dimensions
  local dims = get_window_dimensions(config)

  local buf = nil
  -- Create buffer for terminal
  --
  local create_fresh = not vim.api.nvim_buf_is_valid(state[config.title].buf)
  if not create_fresh then
    buf = state[config.title].buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Set up floating window configuration
  local win_opts = {
    relative = 'editor',
    style = 'minimal',
    row = dims.row,
    col = dims.col,
    width = dims.width,
    height = dims.height,
    border = 'rounded',
    title = config.title or "Terminal"
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  if create_fresh and config.cmd then
    vim.fn.jobstart(config.cmd, { term = true })
  elseif create_fresh then
    vim.fn.jobstart(vim.o.shell, { term = true })
  end
  -- Start terminal in the buffer

  -- Set buffer options
  vim.api.nvim_set_option_value('buflisted', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'terminal', { buf = buf })

  -- Enter terminal mode automatically
  vim.cmd('startinsert')

  -- Set up autocommand for window resize
  local group = vim.api.nvim_create_augroup('FloatingTerminal' .. (config.title or 'Terminal'), { clear = true })
  vim.api.nvim_create_autocmd('VimResized', {
    group = group,
    buffer = buf,
    callback = function()
      local new_dims = get_window_dimensions(config)
      vim.api.nvim_win_set_config(win, {
        relative = 'editor',
        row = new_dims.row,
        col = new_dims.col,
        width = new_dims.width,
        height = new_dims.height
      })
    end
  })

  state[config.title] = { buf = buf, win = win }
  -- Return buffer and window IDs for further customization
  return { buf = buf, win = win }
end

M.toggle_terminal = function(config)
  config = config or { title = 'Terminal' }
  --print(vim.inspect(state['test']))
  if not vim.api.nvim_win_is_valid(state[config.title].win) then
    M.create_terminal(config)
  else
    vim.api.nvim_win_hide(state[config.title].win)
  end
end

vim.api.nvim_create_user_command("FloatingTerminal", M.toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, "<leader>tt", M.toggle_terminal, { desc = "[T]oggle [T]erminal" })
vim.keymap.set({ 'n', 't' }, "<leader>tg", function() M.toggle_terminal { title = "Lazygit", cmd = "lazygit" } end,
  { desc = "[T]oggle Lazy[G]it" })
vim.keymap.set({ 'n', 't' }, "<leader>txb",
  function() M.toggle_terminal { title = "xmake build results", cmd = "xmake build" } end,
  { desc = "[T]oggle Lazy[G]it" })
vim.keymap.set({ 'n', 't' }, "<leader>txr", function() M.toggle_terminal { title = "xmake run", cmd = "xmake run" } end,
  { desc = "[T]oggle Lazy[G]it" })

return M
