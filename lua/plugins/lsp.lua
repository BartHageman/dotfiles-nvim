local function setUpLSPKeybinds(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then return end
  local map = vim.keymap.set
  -- Diagnostic keymaps
  map('n', '<leader>e', function() vim.diagnostic.open_float { border = 'rounded' } end,
    { desc = 'Show diagnostic [E]rror messages' })
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
  map('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, { desc = 'Show next diagnostic message' })
  map('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, { desc = 'Show previous diagnostic message' })
end

local function setSigns()
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅜',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '󰌵',
      }
    },
  })
end

return {
  {
    "williamboman/mason.nvim",
    -- version = "^1.0.0",
    dependencies = {
    },
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "neovim/nvim-lspconfig",
        config = function()
          -- LSP settings (for overriding per client)
          setSigns()

          vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if not client then return end
              setUpLSPKeybinds(args)
              if client.supports_method('textDocument/formatting') then
                -- Format the current buffer on save
                vim.api.nvim_create_autocmd('BufWritePre', {
                  buffer = args.buf,
                  callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                  end,
                })
              end
            end,
          })
        end,
        dependencies = {
          {
            "folke/lazydev.nvim",
            ft = "lua",     -- only load on lua files
            opts = {
              library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
              },
            },
          },
        }
      },
    },
  },
}
