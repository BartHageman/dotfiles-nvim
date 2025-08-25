return {
  "chrisgrieser/nvim-spider",
  lazy = true,
  opt = {
    skipInsignificantPunctuation = false,
    consistentOperatorPending = false, -- see the README for details
    subwordMovement = true,
    customPatterns = {},               -- see the README for details
  },
  keys = {
    { "<leader>w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
    { "<leader>e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
    { "<leader>b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
  },
}
