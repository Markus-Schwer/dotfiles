{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      # font = {
      #   package = pkgs.jetbrains-mono;
      #   name = "JetBrains Mono";
      #   size = 14;
      # };
      # window.opacity = "0.85";
      # colors.primary.background = "#181a1f";
    };
  };
}
