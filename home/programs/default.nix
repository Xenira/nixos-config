{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.programs;
in
{
  options.pi.programs = {
    enable = lib.mkEnableOption "Enable program configurations";
  };

  imports = [
    ./nheko.nix
    ./peazip.nix
    ./steam.nix
    ./thunderbird.nix
    ./vivaldi.nix
  ];

  config = lib.mkIf config.pi.programs.enable {
    pi.programs = {
      nheko.enable = lib.mkDefault config.pi.programs.enable;
      peazip.enable = lib.mkDefault config.pi.programs.enable;
      steam.enable = lib.mkDefault (cfg.enable && !config.pi.work.enable);
      thunderbird.enable = lib.mkDefault config.pi.programs.enable;
      vivaldi.enable = lib.mkDefault config.pi.programs.enable;
    };
  };
}
