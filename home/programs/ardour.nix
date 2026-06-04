{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.programs.ardour = {
    enable = lib.mkEnableOption "Enable ardour configuration";
  };

  config = lib.mkIf config.pi.programs.ardour.enable {
    users.users.ls.packages = with pkgs; [
      ardour
    ];
  };
}
