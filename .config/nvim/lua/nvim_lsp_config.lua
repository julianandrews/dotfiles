vim.lsp.config('rust_analyzer', {
    on_attach=function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
})

vim.lsp.enable({'pyright', 'bashls', 'tsserver', 'terraformls', 'yamlls', 'rust_analyzer'})
