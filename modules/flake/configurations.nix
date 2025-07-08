{ lib, inputs, ... }:
let
  darwinHosts = [
    "hrk"
  ];
  mkDarwin =
    host:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../darwin
        { networking.hostName = lib.mkDefault host; }
        ../../hosts/${host}.nix
      ];
    };
in
{
  flake.darwinConfigurations = lib.genAttrs darwinHosts mkDarwin;
}
