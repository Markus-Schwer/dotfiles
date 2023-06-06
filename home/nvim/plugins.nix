{ pkgs }: with pkgs.vimPlugins; [
  onedark-nvim

  # LSP
  nvim-lspconfig
  lsp_lines-nvim
  nvim-cmp
  cmp-nvim-lsp
  #{
  #  plugin = nvim-lspconfig;
  #  config = readFile ./config/lsp.lua;
  #}
  #lsp-status-nvim

  comment-nvim
  vim-surround
  undotree
  telescope-nvim
  {
    plugin = twilight-nvim;
    config = ''
    '';
  }

  # highlighting stuff
  #{
  #  plugin = (nvim-treesitter.withPlugins
  #    (
  #      plugins: with pkgs.tree-sitter-grammars; [
  #        tree-sitter-rust
  #        tree-sitter-nix
  #        tree-sitter-lua
  #      ]
  #    ));
  #  #config = readFile ./config/tree-sitter.lua;
  #}
  #nvim-treesitter-context
]
