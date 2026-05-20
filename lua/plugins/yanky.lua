return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  opts = {
    highlight = { timer = 200 },
  },
  keys = {
    { "y",  "<Plug>(YankyYank)",                       mode = { "n", "x" }, desc = "Yank" },
    { "p",  "<Plug>(YankyPutAfter)",                   mode = { "n", "x" }, desc = "Put after" },
    { "P",  "<Plug>(YankyPutBefore)",                  mode = { "n", "x" }, desc = "Put before" },
    { "gp", "<Plug>(YankyGPutAfter)",                  mode = { "n", "x" }, desc = "Put after (cursor stays)" },
    { "gP", "<Plug>(YankyGPutBefore)",                 mode = { "n", "x" }, desc = "Put before (cursor stays)" },
    { "<c-n>", "<Plug>(YankyCycleForward)",            desc = "Cycle yank forward" },
    { "<c-p>", "<Plug>(YankyCycleBackward)",           desc = "Cycle yank backward" },
  },
}
