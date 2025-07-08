{ lib, ... }:
{
  system.stateVersion = 4;
  nixpkgs.hostPlatform = lib.systems.examples.aarch64-darwin;
  imports = [ ../modules/darwin/configuration ];
}
