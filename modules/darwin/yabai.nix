# https://github.com/nix-darwin/nix-darwin/blob/24725903c82c555670ad5ba108ca5d75da124a90/modules/services/yabai/default.nix
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.yabai;

  toYabaiConfig =
    opts: concatStringsSep "\n" (mapAttrsToList (p: v: "yabai -m config ${p} ${toString v}") opts);

  # TODO: [@cmacrae] Handle removal of yabai scripting additions
  scriptingAdditionConfig = ''
    yabai -m signal --add event=dock_did_restart action='sudo yabai --load-sa'
    sudo yabai --load-sa
  '';

  configFile =
    mkIf (cfg.config != { } || cfg.extraConfig != "")
      "${pkgs.writeScript "yabairc" (
        concatLines (
          optional (cfg.enableScriptingAddition) scriptingAdditionConfig
          ++ optional (cfg.config != { }) (toYabaiConfig cfg.config)
          ++ optional (cfg.extraConfig != "") cfg.extraConfig
        )
      )}";
in
{
  disabledModules = [ "services/yabai" ];
  options = with types; {
    services.yabai.enable = mkOption {
      type = bool;
      default = false;
      description = "Whether to enable the yabai window manager.";
    };

    services.yabai.package = mkOption {
      type = path;
      default = pkgs.yabai;
      description = "The yabai package to use.";
    };

    services.yabai.enableScriptingAddition = mkOption {
      type = bool;
      default = false;
      description = ''
        Whether to enable yabai's scripting-addition.
        SIP must be disabled for this to work.
      '';
    };

    services.yabai.config = mkOption {
      type = attrs;
      default = { };
      example = literalExpression ''
        {
          focus_follows_mouse = "autoraise";
          mouse_follows_focus = "off";
          window_placement    = "second_child";
          window_opacity      = "off";
          top_padding         = 36;
          bottom_padding      = 10;
          left_padding        = 10;
          right_padding       = 10;
          window_gap          = 10;
        }
      '';
      description = ''
        Key/Value pairs to pass to yabai's 'config' domain, via the configuration file.
      '';
    };

    services.yabai.extraConfig = mkOption {
      type = lines;
      default = "";
      example = literalExpression ''
        yabai -m rule --add app='System Preferences' manage=off
      '';
      description = "Extra arbitrary configuration to append to the configuration file";
    };
  };

  config = mkMerge [
    (mkIf (cfg.enable) {
      environment.systemPackages = [ cfg.package ];

      launchd.user.agents.yabai = {
        serviceConfig.ProgramArguments =
          [ "${cfg.package}/bin/yabai" ]
          ++ optionals (cfg.config != { } || cfg.extraConfig != "") [
            "-c"
            configFile
          ];

        serviceConfig.KeepAlive = true;
        serviceConfig.RunAtLoad = true;
        serviceConfig.EnvironmentVariables = {
          PATH = "${cfg.package}/bin:${config.environment.systemPath}";
        };
      };
    })

    (mkIf (cfg.enableScriptingAddition) {
      environment.etc."sudoers.d/yabai".source = pkgs.runCommand "sudoers-yabai" { } ''
        YABAI_BIN="${cfg.package}/bin/yabai"
        SHASUM=$(sha256sum "$YABAI_BIN" | cut -d' ' -f1)
        cat <<EOF >"$out"
        %admin ALL=(root) NOPASSWD: sha256:$SHASUM $YABAI_BIN --load-sa
        EOF
      '';
    })
  ];
}
