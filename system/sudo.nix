{ ... }:
{
  # TODO https://github.com/LnL7/nix-darwin/pull/1020
  imports = [ ../modules/pam.nix ];
  security.pam = {
    enableSudoTouchIdAuth = true;
    enablePamReattach = true;
  };
}
