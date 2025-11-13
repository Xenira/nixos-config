{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.programs.libreoffice = {
    enable = lib.mkEnableOption "Enable Pear configuration";
  };

  config = lib.mkIf config.pi.programs.libreoffice.enable {
    users.users.ls.packages = with pkgs; [
      libreoffice-fresh
    ];
  };
}
