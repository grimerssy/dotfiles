{ config, pkgs, ... }:
let
  cfg = config.security.pam;
  mkSudoTouchIdAuthScript = isEnabled:
    let
      file = "/etc/pam.d/sudo";
      option = "security.pam.enableSudoTouchIdAuth";
      sed = "${pkgs.gnused}/bin/sed";
    in ''
      ${if isEnabled then ''
        if ! grep '${option}' ${file} > /dev/null; then
          ${sed} -i '2i\
        auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so # nix-darwin: ${option}\
        auth       sufficient     pam_tid.so # nix-darwin: ${option}
          ' ${file}
        fi
      '' else ''
        if grep '${option}' ${file} > /dev/null; then
          ${sed} -i '/${option}/d' ${file}
        fi
      ''}
    '';
in {
  config = {
    system.activationScripts.extraActivation.text = ''
      echo >&2 "setting up pam..."
      ${mkSudoTouchIdAuthScript cfg.enableSudoTouchIdAuth}
    '';
  };
}