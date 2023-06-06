{ pkgs }: with pkgs.vimPlugins; [
  # Theme
  onedark-nvim

  # LSP
  nvim-lspconfig
  lsp_lines-nvim
  luasnip
  nvim-cmp
  cmp-nvim-lsp
  lsp-status-nvim

  comment-nvim
  vim-surround
  undotree
  telescope-nvim

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
