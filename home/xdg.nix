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
      };
    };
  };
}
