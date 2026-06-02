return {
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
      overwrite = {
        -- Defer to the existing TextYankPost autocmd in init.lua.
        yank = { enabled = false },
        paste = { enabled = false },
      },
    },
  },
}
