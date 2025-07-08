{
  pkgs,
  inputs,
  ...
}:

let
  branches = { inherit (inputs) nixpkg-stable nixpkgs-unstable nixpkgs-master; };
  cfg = with pkgs; {
    inherit config overlays;
    localSystem = stdenv.buildPlatform.system;
    crossSystem = stdenv.hostPlatform.system;
  };
in

{
  _module.args = builtins.mapAttrs (_: branch: import branch cfg) branches;
}
