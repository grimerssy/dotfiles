{ ... }:
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
  imports = [
    ./configurations.nix
    ./formatter.nix
  ];
}
