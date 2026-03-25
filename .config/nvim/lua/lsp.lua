vim.lsp.config('rust_analyzer', {
  cmd = { '/usr/bin/rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
})

vim.lsp.enable('rust_analyzer')

vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { '.git', 'pyproject.toml', 'setup.py', 'requirements.txt', '.venv' },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.enable('basedpyright')

vim.lsp.config('bash_language_server', {
  cmd = { 'bash-language-server', '--stdio' },
  filetypes = { 'bash', 'sh', 'zsh' },
  root_markers = { '.git', '.bashrc', '.zshrc' },
})

vim.lsp.enable('bash_language_server')

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

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.rs' },
  callback = function(args)
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.py' },
  callback = function(args)
    vim.lsp.buf.format({ async = false, formatters = { 'ruff' } })
  end,
})
