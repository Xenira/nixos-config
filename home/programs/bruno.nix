{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.programs.bruno = {
    enable = lib.mkEnableOption "Enable Bruno configuration";
  };

  config = lib.mkIf config.pi.programs.bruno.enable {
    users.users.ls.packages = with pkgs; [
      bruno
    ];
  };
}
