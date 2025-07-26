{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  programs = [
    "discord"
    "dust"
    "ffmpeg"
    "httpie"
    "stats"
    "telegram-desktop"
  ];
  mkProgramOptions = program: {
    enable = mkEnableOption program;
    package = mkPackageOption pkgs program { };
  };
  enabledPrograms = filter (program: config.programs.${program}.enable) programs;
in

{
  options = {
    programs = listToAttrs (
      map (program: {
        name = program;
        value = mkProgramOptions program;
      }) programs
    );
  };
  config = {
    home.packages = map (program: config.programs.${program}.package) enabledPrograms;
  };
}
