{ config, lib, pkgs, ... }:

let
  cfg = config.pi.programs.steam;
in {
  options.pi.programs.steam.enable = lib.mkEnableOption "Enable Steam configuration";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      steam
    ];
  };
}
