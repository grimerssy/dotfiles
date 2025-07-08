{ lib, inputs, ... }:

with lib;

let
  mapInputs =
    f:
    mapAttrs f {
      inherit (inputs)
        nixpkgs
        nixpkgs-stable
        nixpkgs-unstable
        flakes
        ;
      system = inputs.self;
    };
in

{
  nix = {
    enable = true;
    optimise.automatic = true;
    registry = mapInputs (_: flake: { inherit flake; });
    nixPath = mapInputs (_: x: x);
    settings = {
      flake-registry = "";
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
}
