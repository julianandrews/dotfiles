require ("config.lazy")
require ("lsp")

-- General settings
vim.opt.title = true
vim.opt.number = true
vim.opt.cmdheight = 2
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Tab / Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Filetype detection and indentation
vim.cmd("filetype plugin indent on")

-- Grep program (if ripgrep is available)
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
