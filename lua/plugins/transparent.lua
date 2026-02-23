--xiyaowong/transparent.nvim
return {
  { 
  'xiyaowong/transparent.nvim',
  dependencies = {'nvim-lualine/lualine.nvim'},
  lazy = false,
  config = function()
    require('transparent').setup{}
  end
  }
}
