{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 1.0;
      };
      colors.primary = {
        background = "#f8f8f8";
        foreground = "#2a2b33";
      };
      colors.normal = {
        black   = "#000000";
        red     = "#de3d35";
        green   = "#3e953a";
        yellow  = "#d2b67b";
        blue    = "#2f5af3";
        magenta = "#a00095";
        cyan    = "#3e953a";
        white   = "#bbbbbb";
      };
      colors.bright = {
        black   = "#000000";
        red     = "#de3d35";
        green   = "#3e953a";
        yellow  = "#d2b67b";
        blue    = "#2f5af3";
        magenta = "#a00095";
        cyan    = "#3e953a";
        white   = "#ffffff";
      };
      # colors.primary.background = "#181a1f";
      font.normal.family = "JetBrainsMono Nerd Font";
    };
  };
}
