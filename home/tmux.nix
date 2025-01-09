{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 0;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      sessionist
      {
        plugin = tmux-fzf;
        extraConfig = "TMUX_FZF_LAUNCH_KEY=\"C-f\"";
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15' # minutes
        '';
      }
    ];
    extraConfig = ''
      set -s copy-command 'wl-copy'

      # vim-sytle copy/paste
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'

      # kill-pane
      bind -r q kill-pane

      # vim-style pane resizing
      bind -r C-k resize-pane -U
      bind -r C-j resize-pane -D
      bind -r C-h resize-pane -L
      bind -r C-l resize-pane -R

      # vim-style pane switching
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
    '';
  };
}
