return {
  {
  'kevinhwang91/nvim-ufo',
  dependencies = {'kevinhwang91/promise-async'},
  config = function()

    vim.opt.foldcolumn = '1' -- '0' is not bad
    vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
end
},
{
  "luukvbaal/statuscol.nvim", config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { text = { "%s" },             click = "v:lua.ScSa" },
        { text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa" },
      },
    })
  end,
}
}
