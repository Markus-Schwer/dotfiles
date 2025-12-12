{ pkgs, pkgs-unstable, ... }: ''
  require("mason").setup()
  require("mason-lspconfig").setup()
  vim.lsp.set_log_level("debug")

  local function use_exec_or_fallback(exec, fallback, arg)
      local cmd = {}
      if vim.fn.executable(exec) == 1 then
          table.insert(cmd, exec)
      else
          table.insert(cmd, fallback)
      end
      if arg ~= nil then
          table.insert(cmd, arg)
      end
      return cmd
  end

  local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
          if desc then
              desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      if client.server_capabilities.documentFormattingProvider then
          nmap('<leader>lf', vim.lsp.buf.format, '[l]sp do [f]ormatting')
      end

      nmap('gd', vim.lsp.buf.definition, '[g]o to [d]efinition')
      nmap('gi', vim.lsp.buf.implementation, '[g]o to [i]mplementation')
      nmap('gr', vim.lsp.buf.references, '[g]o to [r]eferences')
      nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
      nmap('<leader>d', vim.lsp.buf.signature_help, 'show signature help [d]ocumentation')
      nmap('<leader>df', vim.diagnostic.open_float, 'show [d]iagnostics [f]loat')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ctions')
      nmap('H', vim.lsp.buf.hover, '[H]over')
      nmap('<leader>f', vim.lsp.buf.format, '[f]ormat buffer')
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  vim.lsp.config('lua_ls', {
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
      cmd = use_exec_or_fallback("lua-language-server", "${pkgs.lua-language-server}/bin/lua-language-server"),
  })

  vim.lsp.config('nil_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("nil", "${pkgs.nil}/bin/nil"),
  })

  vim.lsp.config('bashls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("bash-language-server", "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server", "start"),
  })

  vim.lsp.config('rust_analyzer', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("rust-analyzer", "${pkgs.rust-analyzer}/bin/rust-analyzer"),
  })

  vim.lsp.config('clangd', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("clangd", "${pkgs.clang-tools}/bin/clangd"),
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
  })

  vim.lsp.config('jsonls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("vscode-json-language-server", "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server", "--stdio"),
  })

  vim.lsp.config('html', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("vscode-html-language-server", "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server", "--stdio"),
  })

  vim.lsp.config('cssls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("vscode-css-language-server", "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server", "--stdio"),
  })

  vim.lsp.config('kotlin_language_server', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("kotlin-language-server", "${pkgs-unstable.kotlin-language-server}/bin/kotlin-language-server"),
      init_options = {
        storagePath = "/home/markus/.cache/kotlin-language-server"
      }
  })

  vim.lsp.config('angularls', {
      capabilities = capabilities,
      on_attach = on_attach,
  })

  vim.lsp.config('eslint', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("vscode-json-language-server", "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server", "--stdio"),
  })

  vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("typescript-language-server", "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio"),
  })

  vim.lsp.config('tailwindcss', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("tailwindcss-language-server", "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server", "--stdio"),
  })

  vim.lsp.config('pyright', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("pyright", "${pkgs.pyright}/bin/pyright-langserver", "--stdio"),
  })

  vim.lsp.config('gopls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("gopls", "${pkgs.gopls}/bin/gopls"),
      settings = {
        gopls = {
          buildFlags = {"-tags=api,unit,int"},
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          experimentalPostfixCompletions = true,
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
        }
      }
  })

  vim.lsp.config('golangci_lint_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("golangci-lint-langserver", "${pkgs.golangci-lint-langserver}/bin/golangci-lint-langserver"),
      filetypes = { 'go', 'gomod' },
      init_options = {
        command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
      },
      before_init = nil,
      -- TODO: check if v1 or v2 is available (including go tool) and use corresponding command or fall back to nixpkg (v2)
  })

  vim.lsp.config('templ', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("templ", "${pkgs-unstable.templ}/bin/templ", "lsp"),
  })

  vim.lsp.config('terraformls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("terraform-ls", "${pkgs.terraform-ls}/bin/terraform-ls", "serve"),
  })

  vim.lsp.config('protols', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = use_exec_or_fallback("protols", "${pkgs.protols}/bin/protols"),
  })
''
