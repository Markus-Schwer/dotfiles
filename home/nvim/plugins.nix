{ pkgs }: with pkgs.vimPlugins;
let
  mason = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "mason";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "mason.nvim";
      rev = "7d7efc738e08fc5bee822857db45cb6103f0b0c1";
      sha256 = "1m8irg61mzw2pcgc9r6nf0v9ch5pgmwq0n1qx8lclwwzxfbwgzdl";
    };
  };
  mason-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "mason-lspconfig";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "mason-lspconfig.nvim";
      rev = "5230617372e656d4a2e1e236e03bf7e7b4b97273";
      sha256 = "1wfdb1cbqkyh24f3y7hswl2b41s7r2cz0s6ms5az5jfa2a56m1wl";
    };
  };
  ccls-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "ccls";
    src = pkgs.fetchFromGitHub {
      owner = "ranjithshegde";
      repo = "ccls.nvim";
      rev = "37c772b07d25054a51ec36f1767e1d64224fb38d";
      sha256 = "1dsjbbvh870nzwm6smj905bb75h90kpp1ha0ayfq3b0iv16jxk5f";
    };
  };
in
[
  # Theme
  onedark-nvim

  # LSP
  nvim-lspconfig
  lsp_lines-nvim
  luasnip
  nvim-cmp
  cmp-cmdline
  cmp-nvim-lsp
  lsp-status-nvim
  mason
  mason-lspconfig
  ccls-nvim

  # highlighting
  nvim-treesitter.withAllGrammars
  nvim-treesitter-context

  telescope-nvim
  telescope-fzf-native-nvim

  comment-nvim
  nvim-ts-context-commentstring
  vim-surround
  undotree
  telescope-nvim
]
