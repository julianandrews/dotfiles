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
    -- Handled by rust-tools
    -- nvim_lsp.rust_analyzer.setup{
    --     on_attach=on_attach,
    --     settings = {
    --         ["rust-analyzer"] = {
    --             diagnostics = {
    --                 disabled = { "unresolved-proc-macro" }
    --             },
    --         },
    --     },
    -- }
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
