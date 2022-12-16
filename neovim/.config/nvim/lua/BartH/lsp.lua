local lsp = require('lsp-zero')

lsp.preset('lsp-compe')
require('BartH.setups.cmp')
lsp.set_preferences({
    cmp_capabilities = true,
    set_lsp_keymaps = false
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  local bind = function(lhs, rhs) 
        vim.keymap.set("n", lhs, rhs, opts)
  end
    bind("gd", vim.lsp.buf.definition)
    bind("gD", vim.lsp.buf.declaration)
    bind("gr", vim.lsp.buf.references)
    bind("gi", vim.lsp.buf.implementation)
    bind("dn", vim.diagnostic.goto_prev)
    bind("dp", vim.diagnostic.goto_next)
    bind("K", vim.lsp.buf.hover)
    bind("<leader>rn", vim.lsp.buf.rename)
    bind("<leader>ca", vim.lsp.buf.code_action)
    bind("<leader>sd" ,vim.diagnostic.open_float)
end)

lsp.configure('sumneko_lua', {
 settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
lsp.setup()
