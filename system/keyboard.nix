{ pkgs, ... }: {
  system.keyboard =
    let
      capsLock = 30064771129;
      rctrl = 30064771300;
    in
    {
      enableKeyMapping = true;
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingSrc = capsLock;
          HIDKeyboardModifierMappingDst = rctrl;
        }
      ];
    };
  services.skhd =
    let
      package = pkgs.skhd;
    in
    {
      inherit package;
      enable = true;
      skhdConfig =
        let
          hyper = [ "rctrl" ];

          skhd = "${package}/bin/skhd";
          xargs = "xargs";
          sh = "${pkgs.bash}/bin/sh";
          jq = "${pkgs.jq}/bin/jq";
          yabai = "${pkgs.yabai}/bin/yabai";
          alacritty = "$HOME/Applications/Home\\ Manager\\ Apps/Alacritty.app";

          newSpaceForWindow = ''
            ${yabai} -m space --create && \
            ${yabai} -m query --spaces --display | \
            ${jq} -re '[.[] | select(."is-native-fullscreen" | not)][-1].index' | \
            ${xargs} ${sh} -c '\
            ${yabai} -m window --space $1 && \
            ${yabai} -m space --focus $1 \
            ' _ \
          '';

          hotkeys = [
            [ hyper "space" "${skhd} --key escape" ]
            [ hyper "return" "open -n ${alacritty}" ]
            [ hyper "c" newSpaceForWindow ]
            [ hyper "b" "${yabai} -m space --balance" ]
            [ hyper "v" "${yabai} -m window --toggle split" ]
            [ hyper "s" "${yabai} -m window --toggle sticky" ]
            [ hyper "f" "${yabai} -m window --toggle zoom-fullscreen" ]
            [ hyper "m" "${yabai} -m space --toggle mission-control" ]
          ];

          vimMode =
            let
              keys = {
                h = "left";
                j = "down";
                k = "up";
                l = "right";
              };
              modSets = [
                [ ]
                [ "alt" ]
                [ "cmd" ]
                [ "shift" ]
                [ "shift" "alt" ]
                [ "shift" "cmd" ]
              ];
              hotkey = mods: from: to: [
                (hyper ++ mods)
                from
                "${skhd} --key '${keysym mods to}'"
              ];
            in
            builtins.concatMap (mods: mapSet (hotkey mods) keys) modSets;

          windowManagement =
            let
              spaces =
                {
                  n = "next";
                  p = "prev";
                  r = "recent";
                }
                // builtins.listToAttrs (
                  map
                    (space: {
                      name = toString (mod space 10);
                      value = toString space;
                    })
                    (builtins.genList (x: x + 1) 10)
                );
              windows = {
                u = "north";
                d = "south";
                w = "west";
                e = "east";
              };
              focusSpace = key: space: [
                hyper
                key
                "${yabai} -m space --focus ${space}"
              ];
              insertNewSpace = key: space: [
                (hyper ++ [ "cmd" ])
                key
                "${newSpaceForWindow} && ${yabai} -m space --move ${space}"
              ];
              sendWindow = key: space: [
                (hyper ++ [ "alt" ])
                key
                "${yabai} -m window --space ${space}"
              ];
              moveSpace = key: space: [
                (hyper ++ [ "ctrl" ])
                key
                "${yabai} -m space --move ${space}"
              ];
              focusWindow = key: window: [
                hyper
                key
                "${yabai} -m window --focus ${window}"
              ];
              swapWindow = key: window: [
                (hyper ++ [ "cmd" ])
                key
                "${yabai} -m window --swap ${window}"
              ];
              applyHotkeys = keymap: builtins.concatMap (hotkey: mapSet hotkey keymap);
            in
            builtins.concatMap (bind applyHotkeys) [
              [ spaces [ focusSpace insertNewSpace sendWindow moveSpace ] ]
              [ windows [ focusWindow swapWindow ] ]
            ];

          mod = x: y: x - x / y * y;
          mapSet = f: set: map (field: f field set.${field}) (builtins.attrNames set);
          keysym = mods: key:
            builtins.concatStringsSep " - " (
              if builtins.length mods != 0
              then [ (builtins.concatStringsSep " + " mods) key ]
              else [ key ]
            );
          action = mods: key: command: (keysym mods key) + " : " + command;
          bind = f: args:
            let
              x = f (builtins.head args);
              rest = builtins.tail args;
            in
            if builtins.length rest == 0
            then x
            else bind x rest;
        in
        builtins.concatStringsSep "\n" (
          builtins.concatMap (map (bind action)) [ hotkeys vimMode windowManagement ]
        );
    };
}
