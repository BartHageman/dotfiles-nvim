---@diagnostic disable: missing-fields
return {

  "neanias/everforest-nvim",
  {
    "rose-pine/neovim",
    name = "rose-pine"
  },
  {'AlexvZyl/nordic.nvim'},
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "sainnhe/gruvbox-material",
  },
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
  --         palette.bg0 = "#231E1C" -- Main BG
  --         palette.bg1 = "#241e1c"
  --         palette.bg2 = "#382f2d"
  --         palette.bg3 = "#FFFFFF" --"#493a36"
  --         palette.bg4 = "#382e2b"   -- Empty Line chars
  --         palette.bg5 = "#594a47"   -- Line Nos.
  --         palette.grey0 = "#928181"
  --         palette.grey1 = "#978787" -- Comments
  --         palette.grey2 = "#D0A46A" -- Comments
  --         palette.fg = "#c9b397"
  --         palette.red = "#BF6953"
  --         palette.orange = "#C68357"
  --         palette.yellow = "#C9A55B"
  --         palette.green = "#a0a762"
  --         palette.aqua = "#789e8b"
  --         palette.blue = "#7d8c9c"
  --         palette.purple = "#b3848f"
  --         -- palette.red = "#ea7c72"
  --         -- palette.orange = "#e59c6b"
  --         -- palette.yellow = "#dbb15b"
  --         -- palette.green = "#acc475"
  --         -- palette.aqua = "#72C2AB"
  --         -- palette.blue = "#70B7CE"
  --         -- palette.purple = "#E79EC1"
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
