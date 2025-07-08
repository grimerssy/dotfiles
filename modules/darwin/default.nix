{ inputs, ... }:
{
  imports = [
    inputs.mac-app-util.darwinModules.default
    ../system
    ./home-manager.nix
    ./keyboard.nix
    ./shell.nix
    ./users.nix
  ];
}
