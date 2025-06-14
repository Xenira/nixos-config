{ config, lib, pkgs, ... }:

{
  options.pi.programs.peazip = {
    enable = lib.mkEnableOption "Enable Pear configuration";
  };

  config = lib.mkIf config.pi.programs.peazip.enable {
    users.users.ls.packages = with pkgs; [
      peazip
    ];
    home-manager.users.ls = {
      xdg = {
        mimeApps = {
          associations.added = {
            "application/zip" = ["peazip.desktop" "peazip-extract-here.desktop"];
            "application/x-compressed-tar" = "peazip.desktop";
          };
        };
      };
    };
  };
}
