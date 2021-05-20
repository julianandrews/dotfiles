lua <<EOF

-- check and load the various plugins I use
local has_nvim_lsp,nvim_lsp = pcall(require, 'lspconfig')
local has_completion,completion = pcall(require, 'completion')
local has_lsp_extensions,_ = pcall(require, 'lsp_extensions')

-- Enable langauge servers
if has_nvim_lsp then
    local servers = { "bashls", "pyright", "rust_analyzer", "tsserver", "vimls", "yamlls" }
    local on_attach = function(client)
        if has_completion then
            completion.on_attach(client)
        end
    end

    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup { on_attach = on_attach }
    end
end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- turn on inlay_hints for Rust
if has_lsp_extensions then
    vim.api.nvim_command([[
        autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost
        \ * lua require'lsp_extensions'.inlay_hints{
        \ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
        \ }
    ]])
end
EOF

" lsp config
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" completion config
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<S-Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)
