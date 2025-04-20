{ pkgs, pkgs-unstable, ... }: with pkgs.vimPlugins;
let
  mason = pkgs.vimUtils.buildVimPlugin {
    name = "mason";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "mason.nvim";
      rev = "7d7efc738e08fc5bee822857db45cb6103f0b0c1";
      sha256 = "1m8irg61mzw2pcgc9r6nf0v9ch5pgmwq0n1qx8lclwwzxfbwgzdl";
    };
  };
  mason-lspconfig = pkgs.vimUtils.buildVimPlugin {
    name = "mason-lspconfig";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "mason-lspconfig.nvim";
      rev = "5230617372e656d4a2e1e236e03bf7e7b4b97273";
      sha256 = "1wfdb1cbqkyh24f3y7hswl2b41s7r2cz0s6ms5az5jfa2a56m1wl";
    };
  };
  ccls-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "ccls";
    src = pkgs.fetchFromGitHub {
      owner = "ranjithshegde";
      repo = "ccls.nvim";
      rev = "37c772b07d25054a51ec36f1767e1d64224fb38d";
      sha256 = "1dsjbbvh870nzwm6smj905bb75h90kpp1ha0ayfq3b0iv16jxk5f";
    };
  };
  nvim-dev-webicons = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-dev-webicons";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-dev-webicons";
      rev = "925e2aa30dc9fe9332060199c19f132ec0f3d493";
      sha256 = "+T88roJ4pa7/2p2Bdevn+wTNAXgGmB+QkaLRq2rtUUQ=";
    };
  };
  telescope-frecency = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-frecency";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-frecency.nvim";
      rev = "771726f7d6e7e96e9273e454b1c1f49168663a37";
      sha256 = "sha256-pvSg50UjlgaB8Bee4b+BbAevjUt8wDxbooeNjlb8vBs=";
    };
  };
  transparent = pkgs.vimUtils.buildVimPlugin {
    name = "transparent-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "xiyaowong";
      repo = "transparent.nvim";
      rev = "f09966923f7e329ceda9d90fe0b7e8042b6bdf31";
      sha256 = "sha256-Z4Icv7c/fK55plk0y/lEsoWDhLc8VixjQyyO6WdTOVw=";
    };
  };
  tabset = pkgs.vimUtils.buildVimPlugin {
    name = "tabset-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "FotiadisM";
      repo = "tabset.nvim";
      rev = "996f95e4105d053a163437e19a40bd2ea10abeb2";
      sha256 = "sha256-kOLN74p5AvZlmZRd2hT5c1uV7qziVcyIB8fpC1RiDPk=";
    };
  };
in
[
  # Theme
  onedark-nvim
  transparent

  # LSP
  nvim-lspconfig
  lsp_lines-nvim
  luasnip
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp-treesitter
  lsp-status-nvim
  mason
  mason-lspconfig
  ccls-nvim
  tabset

  tabset

  # highlighting
  nvim-treesitter.withAllGrammars

  telescope-nvim
  telescope-fzf-native-nvim
  telescope-frecency

  comment-nvim
  vim-surround

  trouble-nvim
  nvim-dev-webicons

  # debug
  nvim-dap
  nvim-dap-ui
  nvim-dap-go

  # sourcegraph cody
  sg-nvim

  # versioning
  undotree
  vim-fugitive
  gitsigns-nvim

  # sops
  nvim-sops
  b64-nvim
]
