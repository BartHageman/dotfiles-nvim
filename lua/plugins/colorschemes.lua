---@diagnostic disable: missing-fields
return {

  --"neanias/everforest-nvim",
  "jpwol/thorn.nvim",
  "EdenEast/nightfox.nvim",
  "mryodo/rwth.nvim",
  {
    "rose-pine/neovim",
    name = "rose-pine"
  },
  {'AlexvZyl/nordic.nvim'},
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "sainnhe/gruvbox-material",
  },
  {"nyoom-engineering/oxocarbon.nvim"},
-- {
--   "neanias/everforest-nvim",
--   version = false,
--   lazy = false,
--   priority = 1000, -- make sure to load this before all the other start plugins
--   -- Optional; default configuration will be used if setup isn't called.
--   --
--   config = function()
--     require("everforest").setup({
--       background = "soft",
--       colours_override = function(palette)
--         palette.bg_dim = "#191515"
--         palette.bg0 = "#112941" -- Main BG
--         palette.bg1 = "#241e1c"
--         palette.bg2 = "#382f2d"
--         palette.bg3 = "#FFFFFF"
--         palette.bg4 = "#382e2b"   -- Empty Line chars
--         palette.bg5 = "#758496"   -- Line Nos.
--         palette.grey0 = "#758496"
--         palette.grey1 = "#91a1b5" -- Comments
--         palette.grey2 = "#91a1b5"
--         palette.fg = "#c8d4db"
--         palette.red = "#e0a8bb"
--         palette.orange = "#7794a5"
--         palette.yellow = "#e5ddb6"
--         palette.green = "#defae7"
--         palette.aqua = "#cef5d4"
--         palette.blue = "#95bccf"
--         palette.purple = "#b3848f"
--        palette.bg_visual = "#563e2a"
--       end,
--     })
--     vim.cmd("colorscheme everforest")
--
--     local source_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
--     local fg_color = "#DE9B44"
--     local bg_color = "#32241C"
--
--     -- Set your highlight with that foreground + custom background
--     vim.api.nvim_set_hl(0, "TelescopeNormal", {
--       fg = fg_color,
--       bg = bg_color  -- or whatever background you want
--     })
--
--     vim.api.nvim_set_hl(0, "TelescopeBorder", {
--       fg = "#D26019",
--       bg = bg_color
--     })
--
--     vim.api.nvim_set_hl(0, "TelescopeMatching", {
--       fg = "#FFD46F",
--       bg = bg_color
--     })
--     --vim.cmd [[hi TelescopeBorder guifg=#BB6232]]
--     vim.cmd [[hi link TelescopeSelection Visual]]
--   end,
-- }
}
