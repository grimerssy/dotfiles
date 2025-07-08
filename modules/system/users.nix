{ config, lib, ... }:

with lib;

let
  cfg = config.users;
in

{
  options.users.normalUsers = mkOption {
    type = types.listOf types.str;
    default = [ ];
    description = ''
      List of "real" users managed by system config.
      This automatically sets
      {option}`name`,
      {option}`isNormalUser` to true on Linux
      or applies equivalent settings on Macos
      and {option}`home-manager.users.<name>.imports`.
    '';
  };

  config.users.users = genAttrs cfg.normalUsers (name: {
    name = mkDefault name;
  });
}
