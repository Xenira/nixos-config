{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.xdg = {
    enable = lib.mkEnableOption "Enable XDG configuration";
  };

  config = lib.mkIf config.pi.xdg.enable {
    home-manager.users.ls = {
      xdg = {
        mime.enable = true;
        mimeApps = {
          enable = true;
          associations.added = {
            "text/plain" = "gvim.desktop";
          };
        };
        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = null;
          publicShare = null;
          templates = null;
        };
        autostart.readOnly = true;
      };
    };
  };
}
