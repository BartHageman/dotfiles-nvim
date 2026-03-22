return {
  'stevearc/aerial.nvim',
  opts = {
      backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
      filter_kind = false
  },
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}
