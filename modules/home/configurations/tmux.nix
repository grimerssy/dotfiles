{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    sensibleOnTop = false; # TODO
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    prefix = "C-a";
    terminal = "tmux-256color";
    # TODO revisit nix options
    extraConfig = ''
      set -g detach-on-destroy off
      set -g allow-rename off

      set -g renumber-windows on
      set -g mouse on

      set -sg terminal-overrides ",*:RGB"

      unbind %
      unbind '"'
      bind \\ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
      bind C-h resize-pane -L 5
      bind C-j resize-pane -D 5
      bind C-k resize-pane -U 5
      bind C-l resize-pane -R 5

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection

      bind r source-file ~/.config/tmux/tmux.conf

      bind C-s display-popup -E "tmux-session"

      bind-key . run-shell 'open -R "$(tmux display-message -p "#{pane_current_path}")"'

      set -g status-position top

      set -g status-justify centre

      set -g status-style 'bg=default'

      set -g status-left-length 32
      set -g status-right-length 32

      # old
      # set -g status-left '#[fg=blue]#[fg=black]#[bg=blue]#{session_name}#[fg=blue]#[bg=default]'
      # set -g status-right '#[bg=default] #{s|.| |:session_name} '
      # set -g window-status-separator '   '

      # TODO when move to stylix fix in unconfigured terminals
      # set -g window-status-format "#[fg=white]#[fg=black]#[bg=white]#I #[fg=white]#[bg=black] #W #[fg=black]#[bg=default]"
      # set -g window-status-current-format "#[fg=blue]#[fg=black]#[bg=blue]#I #[fg=white]#[bg=black] #W #[fg=black]#[bg=default]"
    '';
  };
}
