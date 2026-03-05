local active_flash = nil
local function flash_filename()
  -- kill previous flash immediately
  if active_flash and vim.api.nvim_win_is_valid(active_flash.win) then
    vim.api.nvim_win_close(active_flash.win, true)
    vim.api.nvim_buf_delete(active_flash.buf, { force = true })
  end

  -- Get file icons:
  local devicons = require("nvim-web-devicons")

  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  local ext = vim.fn.fnamemodify(name, ":e")
  local icon, icon_hl = devicons.get_icon(name, ext, { default = true })

  local text = "  " .. icon .. " " .. name .. ""


  --local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  local buf = vim.api.nvim_create_buf(false, true)
  --vim.api.nvim_buf_set_lines(buf, 0, -1, false, { " " .. name .. " " })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })
  text_len = vim.fn.strdisplaywidth(text)
  local width = text_len + 2
  local even_width = math.floor((text_len + 2)/2)*2

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    row = math.floor(vim.o.lines / 2),
    col = math.floor((vim.o.columns - even_width) / 2),

    width = width,
    height = 1,
    style = "minimal",
    border = "rounded",
    focusable = false,
  })
  vim.api.nvim_set_hl(0, "HarpoonFlash", { bg = "None", fg = "#c0caf5", bold = true })
  vim.api.nvim_win_set_option(win, "winhl", "Normal:HarpoonFlash,FloatBorder:Comment")
  active_flash = { win = win, buf = buf }

  vim.defer_fn(function()
    if active_flash and active_flash.win == win then
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
      if vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
      active_flash = nil
    end
  end, 300)
end

local function harpoon_select_n_flash(number)
  local harpoon = require("harpoon")
  harpoon:list():select(number)
  flash_filename()
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require("harpoon")



      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>mm", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>ml", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-h>", function() harpoon_select_n_flash(1) end)
      vim.keymap.set("n", "<C-j>", function() harpoon_select_n_flash(2) end)
      vim.keymap.set("n", "<C-k>", function() harpoon_select_n_flash(3) end)
      vim.keymap.set("n", "<C-l>", function() harpoon_select_n_flash(4) end)

      -- vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      -- vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      -- vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      -- vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end
  }
}
