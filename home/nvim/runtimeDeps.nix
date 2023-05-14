{ pkgs }: let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
    ];
  };
in
{
  deps = with pkgs; [
    rust
    gcc
    cargo

    # langauge servers
    sumneko-lua-language-server
    rnix-lsp
    nodePackages.bash-language-server
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.typescript-language-server
  ];
}
