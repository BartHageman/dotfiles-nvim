-- time-machine.lua
return {
 "y3owk1n/time-machine.nvim",
 version = "*", -- remove this if you want to use the `main` branch
 config = function()
  require("time-machine").setup({
  })

  vim.keymap.set("n", "<leader>u", "<cmd>TimeMachineToggle<cr>")
  end
}
