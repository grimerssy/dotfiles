{ ... }:
{
  home.stateVersion = "24.11";
  # TODO man pages
  imports = [
    ./cli
    ./gui
    ./shell
    ./tui
    ./utils

    # TODO
    ./todo/docker.nix # darwin
    ./todo/scripts.nix # home/darwin program modules
  ];
  programs.git = {
    userName = "Stanislav Stoyanov";
    userEmail = "grimerssy@gmail.com";
  };
}
