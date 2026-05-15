{ nixpkgs, system, pkgs-unstable, lib, ... }:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins.extend (
          finalPlugins: prevPlugins: {
            # pinned because of: https://github.com/nvim-neotest/neotest/issues/531
            # TLDR; newer neotest versions do not find new treesitter grammars from
            # nvim-treesitter/main installed by nix
            neotest = final.vimUtils.buildVimPlugin {
              name = "neotest";
              src = final.fetchFromGitHub {
                owner = "archie-judd";
                repo = "neotest";
                rev = "ce51b2834f6f4e9d9a09c1047a0d1f627b13161a";
                sha256 = "sha256-EpkobU9KzMpvQr+XZKy9abna1q/TZSKr469ggx+tvgk=";
              };
              propagatedBuildInputs = with finalPlugins; [
                nvim-nio
                plenary-nvim
              ];
              doCheck = false;
            };

            # fix neotest dependency
            neotest-golang = prevPlugins.neotest-golang.overrideAttrs (old: {
              propagatedBuildInputs = [ finalPlugins.neotest ];
            });
          }
        );
      })
    ];
  };

  plugins = (import ./plugins.nix { inherit pkgs pkgs-unstable; });

  configDir = import ./config.nix { inherit pkgs pkgs-unstable lib; };

  extraPackages = with pkgs; [
    ripgrep
    fzf
    gcc
    fd
    nodejs_22
    teamtype
  ];

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins;
    vimAlias = false;
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // {
  wrapperArgs = (lib.escapeShellArgs neovimConfig.wrapperArgs)
    + " --suffix PATH : \"${lib.makeBinPath extraPackages}\""
    + " --add-flags '--cmd \"set rtp^=${configDir}\"'"
    + " --add-flags '-u ${configDir}/init.lua'";
  wrapRc = false;
})
