{ ... }:
{
  programs.fish = {
    enable = true;
    shellInit = "set fish_greeting";
    shellAliases.nix-shell = "nix-shell --command fish";
  };
}
