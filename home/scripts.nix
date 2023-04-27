{ pkgs, ... }:
let
  nvim = "nvim";
  fzf = "${pkgs.fzf}/bin/fzf";
  awk = "${pkgs.gawk}/bin/awk";
  rg = "${pkgs.ripgrep}/bin/rg";
  tmux = "${pkgs.tmux}/bin/tmux";
  tr = "${pkgs.coreutils}/bin/tr";
  cut = "${pkgs.coreutils}/bin/cut";
  zoxide = "${pkgs.zoxide}/bin/zoxide";
  sha256sum = "${pkgs.coreutils}/bin/sha256sum";

  restart-de = ''
    launchctl unload "$HOME/Library/LaunchAgents/org.nixos.skhd.plist"
    launchctl unload "$HOME/Library/LaunchAgents/org.nixos.yabai.plist"
    launchctl load "$HOME/Library/LaunchAgents/org.nixos.skhd.plist"
    launchctl load "$HOME/Library/LaunchAgents/org.nixos.yabai.plist"
  '';
  tmux-session = ''
    ZOXIDE_RESULT=$(${zoxide} query "$1")

    if [ $# -eq 0 ] || [ -z "$ZOXIDE_RESULT" ]; then
      ZOXIDE_RESULT=$(${zoxide} query -l | ${fzf} --reverse)
    fi

    if [ -z "$ZOXIDE_RESULT" ]; then
      exit 0
    fi

    SESSION=$(\
      basename "$ZOXIDE_RESULT" | ${tr} "." "-" \
      )-$(echo "$ZOXIDE_RESULT" | ${sha256sum} | ${cut} -c-8)

    EXISTING_SESSION=$(${tmux} list-sessions \
      | ${rg} "$SESSION" \
      | ${awk} '{print $1}')
    EXISTING_SESSION=''${EXISTING_SESSION//:/}

    if [ -z "$EXISTING_SESSION" ]; then
        cd "$ZOXIDE_RESULT" || exit 
        ${tmux} new-session -d -s "$SESSION"
        ${tmux} send-keys -t "$SESSION:1" "${nvim} ." Enter
    fi

    if [ -z "$TMUX" ]; then
        ${tmux} attach -t "$EXISTING_SESSION"
        exit 0
    fi

    ${tmux} switch-client -t "$SESSION"
  '';
in {
  home.packages = [
    (pkgs.writeScriptBin "tmux-session" tmux-session)
    (pkgs.writeScriptBin "restart-de" restart-de)
  ];
}