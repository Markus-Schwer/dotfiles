{ pkgs, pkgs-unstable, ... }: with pkgs.vimPlugins;
let
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
  tabset = pkgs.vimUtils.buildVimPlugin {
    name = "tabset-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "FotiadisM";
      repo = "tabset.nvim";
      rev = "996f95e4105d053a163437e19a40bd2ea10abeb2";
      sha256 = "sha256-kOLN74p5AvZlmZRd2hT5c1uV7qziVcyIB8fpC1RiDPk=";
    };
  };
  guihua = pkgs.vimUtils.buildVimPlugin {
    name = "guihua";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "87bea7b98429405caf2a0ce4d029b027bb017c70";
      hash = "sha256-R/ckeCwzWixvL7q2+brvqcvfSK9Mx8pu6zOFgh2lde4=";
      fetchSubmodules = true;
    };
    buildPhase = ''
      pushd lua/fzy
      make
      popd
    '';
    nvimSkipModules = [
      "fzy.fzy-lua-native"
    ];
  };
in
[
  # Theme
  onedark-nvim
  transparent-nvim

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
  mason-nvim
  mason-lspconfig-nvim
  ccls-nvim
  tabset

  # highlighting
  nvim-treesitter
  nvim-treesitter.withAllGrammars
  nvim-treesitter-textobjects
  nvim-treesitter-context

  telescope-nvim
  telescope-fzf-native-nvim
  telescope-frecency-nvim
  telescope-live-grep-args-nvim

  comment-nvim
  vim-surround
  vim-wordmotion

  trouble-nvim
  nvim-dev-webicons

  # debug
  nvim-dap
  nvim-dap-ui
  nvim-dap-go
  nvim-dap-virtual-text

  # versioning
  undotree
  vim-fugitive
  gitsigns-nvim

  # sops
  nvim-sops
  b64-nvim

  # testing
  neotest
  neotest-golang

  refactoring-nvim

  nvim-lint

  go-nvim
  guihua
]
