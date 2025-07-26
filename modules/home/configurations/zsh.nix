{ pkgs, ... }:
{
  programs.zsh.enable = pkgs.stdenv.hostPlatform.isDarwin;
}
