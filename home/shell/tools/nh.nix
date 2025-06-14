{ pkg, lib, config, ... }:

{
  options.pi.shell.tools.nh = {
    enable = lib.mkEnableOption "Enable nh configuration";
  };

  config = lib.mkIf config.pi.shell.tools.nh.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 30d --keep 25";
      };
    };
  };
}
