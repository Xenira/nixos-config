{ pkgs, lib, config, ... }:

let
  cfg = config.pi.programs;
  vivaldi_desktop = "vivaldi-stable.desktop";
  is_default = cfg.vivaldi.enable && cfg.vivaldi.default;
in {
  options.pi.programs.vivaldi = {
    enable = lib.mkEnableOption "Enable Vivaldi browser configuration";
    default = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Set Vivaldi as the default browser";
    };
  };

  config = lib.mkIf cfg.vivaldi.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vivaldi"
    ];

    home-manager.users.ls = lib.mkIf is_default {
      xdg = {
        mimeApps = {
          enable = true;
          defaultApplications = {
            "text/html" = vivaldi_desktop;
            "text/xml" = vivaldi_desktop;
            "application/xml" = vivaldi_desktop;
            "application/xhtml+xml" = vivaldi_desktop;
            "application/xhtml_xml" = vivaldi_desktop;
            "x-scheme-handler/http" = vivaldi_desktop;
            "x-scheme-handler/https" = vivaldi_desktop;
            "x-scheme-handler/about" = vivaldi_desktop;
            "x-scheme-handler/unknown" = vivaldi_desktop;
          };
        };
      };

      home.packages = with pkgs; [
        vivaldi
        vivaldi-ffmpeg-codecs
      ];

      home.sessionVariables = lib.mkIf is_default {
        DEFAULT_BROWSER = "${pkgs.vivaldi}/bin/vivaldi-stable";
        BROWSER = "${pkgs.vivaldi}/bin/vivaldi-stable";
      };
    };
  };
}
