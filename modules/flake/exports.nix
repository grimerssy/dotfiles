{ ... }:
{
  flake = {
    darwinModules = {
      default.imports = import ../darwin/module-list.nix;
      configurations = import ../darwin/configurations/modules.nix;
    };
    homeManagerModules = {
      default.imports = import ../home/module-list.nix;
      configurations = import ../home/configurations/modules.nix;
    };
  };
}
