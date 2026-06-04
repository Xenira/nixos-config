{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.programs.kdenlive = {
    enable = lib.mkEnableOption "Enable kdenlive configuration";
  };

  config = lib.mkIf config.pi.programs.kdenlive.enable {
    users.users.ls.packages = with pkgs; [
      kdePackages.kdenlive
    ];
  };
}
