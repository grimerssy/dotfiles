{ pkgs, ... }:
let
  fzf = "${pkgs.fzf}/bin/fzf";
  awk = "${pkgs.gawk}/bin/awk";
  rg = "${pkgs.ripgrep}/bin/rg";
  tmux = "${pkgs.tmux}/bin/tmux";
  tr = "${pkgs.coreutils}/bin/tr";
  cut = "${pkgs.coreutils}/bin/cut";
  zoxide = "${pkgs.zoxide}/bin/zoxide";
  sha256sum = "${pkgs.coreutils}/bin/sha256sum";

  # TODO move to program configs
  restart-de =
    let
      launchAgent = service: "$HOME/Library/LaunchAgents/org.nixos.${service}.plist";
      yabai = launchAgent "yabai";
      skhd = launchAgent "skhd";
    in
    ''
      launchctl unload "${skhd}"
      launchctl unload "${yabai}"
      launchctl load "${skhd}"
      launchctl load "${yabai}"
    '';
  tmux-session = ''
    DIR_PATH=$(${zoxide} query "$1")

    if [ $# -eq 0 ] || [ -z "$DIR_PATH" ]; then
      DIR_PATH=$(${zoxide} query -l | ${fzf} --reverse)
    fi

    if [ -z "$DIR_PATH" ]; then
      exit 0
    fi

    SESSION=$(\
      basename "$DIR_PATH" | ${tr} "." "-"\
    )-$(\
      echo "$DIR_PATH" | ${sha256sum} | ${cut} -c-8\
    )

    EXISTING_SESSION=$(\
      ${tmux} list-sessions\
      | ${rg} "$SESSION"\
      | ${awk} '{print $1}'\
    )
    EXISTING_SESSION=''${EXISTING_SESSION//:/}

    if [ -z "$EXISTING_SESSION" ]; then
      cd "$DIR_PATH" || exit
      ${tmux} new-session -d -s "$SESSION"
    fi

    if [ -z "$TMUX" ]; then
      ${tmux} attach -t "$EXISTING_SESSION"
      exit 0
    fi

    ${tmux} switch-client -t "$SESSION"
  '';
in
{
  home.packages = [
    (pkgs.writeScriptBin "restart-de" restart-de)
    (pkgs.writeScriptBin "tmux-session" tmux-session)
  ];
}
