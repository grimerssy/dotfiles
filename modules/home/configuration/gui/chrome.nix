{ nixpkgs-master, ... }:
{
  # TODO flags
  programs.google-chrome.enable = true;
  programs.google-chrome.package = nixpkgs-master.google-chrome;
}
