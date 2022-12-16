local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

-- Append key mappings to lunarvim's defaults for a given mode
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.append_to_defaults(keymaps)
  for mode, mappings in pairs(keymaps) do
    for k, v in ipairs(mappings) do
      customsettings.keys[mode][k] = v
    end
  end
end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

function M.config()
  customsettings.keys = {
    ---@usage change or add keymappings for insert mode
    insert_mode = {
      -- Move current line / block with Alt-j/k ala vscode.
      ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
      -- Move current line / block with Alt-j/k ala vscode.
      ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
      -- navigation
      ["<A-Up>"] = "<C-\\><C-N><C-w>k",
      ["<A-Down>"] = "<C-\\><C-N><C-w>j",
      ["<A-Left>"] = "<C-\\><C-N><C-w>h",
      ["<A-Right>"] = "<C-\\><C-N><C-w>l",
      -- navigate tab completion with <c-j> and <c-k>
      -- runs conditionally
      ["<C-j>"] = { 'pumvisible() ? "\\<down>" : "\\<C-j>"', { expr = true, noremap = true } },
      ["<C-k>"] = { 'pumvisible() ? "\\<up>" : "\\<C-k>"', { expr = true, noremap = true } },
    },

    ---@usage change or add keymappings for normal mode
    normal_mode = {
      -- Resize with arrows
      --["<C-Down>"] = ":resize +2<CR>",
      --["<C-Up>"] = ":resize -2<CR>",
      --["<C-Left>"] = ":vertical resize -2<CR>",
      --["<C-Right>"] = ":vertical resize +2<CR>",

      ["<leader>cd"] = ":cd %:p:h<CR>",
      ["<cr>"] = "o<esc>",
      ["<S-Enter>"] = "O<esc>",
      ["Y"] = "y$",

      ['n'] = 'nzzzv',
      ['N'] = 'Nzzzv',
      ['J'] = 'mzJ`z',

      -- Tab switch buffer

      ["<S-l>"] = ":BufferNext<CR>",
      ["<S-h>"] = ":BufferPrevious<CR>",

      -- Move current line / block with Alt-j/k a la vscode.
      ["<A-j>"] = ":m .+1<CR>==",
      ["<A-k>"] = ":m .-2<CR>==",

      -- QuickFix
      ["]q"] = ":cnext<CR>",
      ["[q"] = ":cprev<CR>",
      ["<C-q>"] = ":call QuickFixToggle()<CR>",
    },

    ---@usage change or add keymappings for terminal mode
    term_mode = {
      -- Terminal window navigation
      ["<C-h>"] = "<C-\\><C-N><C-w>h",
      ["<C-j>"] = "<C-\\><C-N><C-w>j",
      ["<C-k>"] = "<C-\\><C-N><C-w>k",
      ["<C-l>"] = "<C-\\><C-N><C-w>l",
    },

    ---@usage change or add keymappings for visual mode
    visual_mode = {
      -- Better indenting
      ["<"] = "<gv",
      [">"] = ">gv",
      ["p"] = '"_dP',
      -- ["p"] = '"0p',
      -- ["P"] = '"0P',
    },

    ---@usage change or add keymappings for visual block mode
    visual_block_mode = {
      -- Move selected line / block of text in visual mode
      --["K"] = ":move '<-2<CR>gv-gv",
      --["J"] = ":move '>+1<CR>gv-gv",

      -- Move current line / block with Alt-j/k ala vscode.
      ["<A-j>"] = ":m '>+1<CR>gv-gv",
      ["<A-k>"] = ":m '<-2<CR>gv-gv",
    },

    ---@usage change or add keymappings for command mode
    command_mode = {
      -- navigate tab completion with <c-j> and <c-k>
      -- runs conditionally
      ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
      ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    },
  }

  if vim.fn.has "mac" == 1 then
    customsettings.keys.normal_mode["<A-Up>"] = customsettings.keys.normal_mode["<C-Up>"]
    customsettings.keys.normal_mode["<A-Down>"] = customsettings.keys.normal_mode["<C-Down>"]
    customsettings.keys.normal_mode["<A-Left>"] = customsettings.keys.normal_mode["<C-Left>"]
    customsettings.keys.normal_mode["<A-Right>"] = customsettings.keys.normal_mode["<C-Right>"]
  end
end

function M.print(mode)
  print "List of LunarVim's default keymappings (not including which-key)"
  if mode then
    print(vim.inspect(customsettings.keys[mode]))
  else
    print(vim.inspect(customsettings.keys))
  end
end

function M.setup()
  vim.g.mapleader = (customsettings.leader == "space" and " ") or customsettings.leader
  M.load(customsettings.keys)
end

return M
