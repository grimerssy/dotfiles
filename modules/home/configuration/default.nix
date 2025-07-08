{ ... }:
{
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
}

