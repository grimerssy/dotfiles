{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.emptyDirectory;
    goPath = ".go";
  };
}
