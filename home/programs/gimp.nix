{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.programs.gimp = {
    enable = lib.mkEnableOption "Enable gimp configuration";
  };

  config = lib.mkIf config.pi.programs.gimp.enable {
    users.users.ls.packages = with pkgs; [
      gimp
    ];
  };
}
