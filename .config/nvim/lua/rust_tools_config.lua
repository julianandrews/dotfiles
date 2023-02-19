local has_rt,rt = pcall(require, "rust-tools")

if has_rt then
    local has_cmp_nvim_lsp,cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = has_cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities() or {}
    local lsp_attach = function(client, buf)
        vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
        vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end

    -- Setup rust_analyzer via rust-tools.nvim
    rt.setup({
        server = {
            capabilities = capabilities,
            on_attach = lsp_attach,
        }
    })
end
