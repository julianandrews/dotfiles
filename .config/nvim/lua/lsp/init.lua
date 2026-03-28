require("lsp.rust")
require("lsp.python")
require("lsp.typescript")
require("lsp.bash")
require("lsp.yaml")
require("lsp.docker")
require("lsp.clangd")

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', '<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
  end,
})
