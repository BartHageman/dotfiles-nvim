return {
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      }
    },
  },
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
        theme = 'auto',
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = '', right = ''},
        sections = {
          lualine_a = { { 'mode', separator = { left = '',  right = '' }, right_padding = 2 } },
          lualine_x = { 'harpoon2', 'encoding', 'fileformat', 'filetype' },
          lualine_z = { { 'location', separator = { right = '' }, right_padding = 2 } },
        }
      }
  }
}
