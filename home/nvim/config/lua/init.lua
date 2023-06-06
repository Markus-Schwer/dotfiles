vim.lsp.set_log_level("debug")

local on_attach = function(client, bufnr)
    local function nmap(shortcut, command) 
      vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true, silent = true })
    end

    if client.server_capabilities.documentFormattingProvider then
        nmap('<leader>lf', vim.lsp.buf.format, '[l]sp do [f]ormatting')
    end

    nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    nmap('<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    nmap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    nmap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    nmap('<space>f','<cmd>lua vim.lsp.buf.formatting()<CR>')
end

local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspc = require('lspconfig')

lspc.sumneko_lua.setup({
    cmd = { '${pkgs.sumneko-lua-language-server}/bin/lua-language-server' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- disable unknown global 'vim' warning
            diagnostics = { globals = { 'vim' } },
        },
    },
})
