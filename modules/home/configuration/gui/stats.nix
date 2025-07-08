{ pkgs, ... }:
{
  programs.stats.enable = pkgs.stdenv.hostPlatform.isDarwin;
}
