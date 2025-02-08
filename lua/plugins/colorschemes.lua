---@diagnostic disable: missing-fields
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- config = function()
    --   vim.cmd("colorscheme rose-pine-dawn")
    -- end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    --
    config = function()
      require("everforest").setup({
        background = "soft",
        colours_override = function(palette)
          palette.bg_dim = "#191515"
          palette.bg0 = "#191515" -- Main BG
          palette.bg1 = "#241e1c"
          palette.bg2 = "#382f2d"
          palette.bg3 = "#493a36"
          palette.bg4 = "#382e2b"   -- Empty Line chars
          palette.bg5 = "#594a47"   -- Line Nos.
          palette.grey0 = "#928181"
          palette.grey1 = "#978787" -- Comments
          palette.grey2 = "#a08680" -- Comments
          palette.fg = "#c9b397"
          palette.blue = "#70a4b6"
          palette.purple = "#ce87a9"
          palette.aqua = "#6ca796"
          palette.orange = "#e59c6b"
          palette.red = "#ea7c72"
          palette.green = "#acc475"
          palette.yellow = "#dbb15b"
          palette.bg_visual = "#563e2a"
        end,
      })
      vim.cmd("colorscheme everforest")
      vim.cmd [[hi TelescopeBorder guifg=#7f5f55]]
      vim.cmd [[hi link TelescopeSelection Visual]]
    end,
  }
}
