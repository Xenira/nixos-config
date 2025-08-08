{
  config,
  pkgs,
  lib,
  niri,
  ...
}:

let
  cfg = config.pi.niri;
in
{
  nixpkgs.overlays = [ niri.overlays.niri ];
  programs.niri.enable = true;
  home-manager.users.ls = {
    programs.niri = {
      settings = {
        prefer-no-csd = true;
        spawn-at-startup = [ { command = [ "waybar" ]; } ];
        binds = lib.mkMerge [
          {
            "Mod+Return" = {
              action.spawn = "kitty";
              repeat = false;
            };
            "Mod+A" = {
              action.spawn = [
                "tofi-drun"
                "--drun-launch=true"
              ];
              repeat = false;
            };
            "Mod+Shift+E".action.quit = [ ];
            "Mod+Left".action.focus-column-left = [ ];
            "Mod+Right".action.focus-column-right = [ ];
            "Mod+Down".action.focus-window-down = [ ];
            "Mod+Up".action.focus-window-up = [ ];
            "Mod+Ctrl+Left".action.move-column-left = [ ];
            "Mod+Ctrl+Right".action.move-column-right = [ ];
            "Mod+Ctrl+Down".action.move-window-down = [ ];
            "Mod+Ctrl+Up".action.move-window-up = [ ];
            "Mod+Shift+Left".action.focus-monitor-left = [ ];
            "Mod+Shift+Right".action.focus-monitor-right = [ ];
            "Mod+Shift+Down".action.focus-window-down = [ ];
            "Mod+Shift+Up".action.focus-window-up = [ ];
            "Mod+Q" = {
              action.close-window = [ ];
              repeat = false;
            };
            "Mod+T".action.fullscreen-window = [ ];
            "Mod+Ctrl+T".action.maximize-column = [ ];
            "Mod+O".action.toggle-overview = [ ];
          }
          (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            lib.mkMerge (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                {
                  "Mod+${toString ws}".action.focus-workspace = ws;
                  "Mod+Shift+${toString ws}".action.move-column-to-workspace = ws;
                }
              ) 9
            )
          )
        ];
      };
    };
  };
}
