{ pkgs, ... }:
{
  home.packages = with pkgs; [
    docker
    # TODO https://github.com/nix-darwin/nix-darwin/pull/1275
    colima
  ];
}
