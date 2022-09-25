lua <<EOF

-- check and load the various plugins I use
local has_nvim_lsp,nvim_lsp = pcall(require, 'lspconfig')

-- Enable langauge servers
if has_nvim_lsp then
    nvim_lsp.bashls.setup{on_attach=on_attach}
    nvim_lsp.pyright.setup{on_attach=on_attach}
    nvim_lsp.tsserver.setup{on_attach=on_attach}
    nvim_lsp.vimls.setup{on_attach=on_attach}
    nvim_lsp.terraformls.setup{on_attach=on_attach}
    nvim_lsp.arduino_language_server.setup{
        on_attach=on_attach,
        cmd = {
            "arduino-language-server",
            "-cli-config", "$HOME/.arduino15/arduino-cli.yaml"
        }
    }
    nvim_lsp.yamlls.setup{
        on_attach=on_attach,
        settings = {
            ["yaml"] = {
                customTags = {
                    "!Base64",
                    "!Cidr",
                    "!FindInMap sequence",
                    "!GetAtt",
                    "!GetAZs",
                    "!ImportValue",
                    "!Join sequence",
                    "!Ref",
                    "!Select sequence",
                    "!Split sequence",
                    "!Sub sequence",
                    "!Sub",
                    "!And sequence",
                    "!Condition",
                    "!Equals sequence",
                    "!If sequence",
                    "!Not sequence",
                    "!Or sequence",
                },
            },
        },
    }
    nvim_lsp.rust_analyzer.setup{
        on_attach=on_attach,
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    disabled = { "unresolved-proc-macro" }
                },
            },
        },
    }
    nvim_lsp.clangd.setup{
        on_attach=on_attach,
        cmd = { "clangd-9", "--background-index" },
    }
end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" lsp config
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
