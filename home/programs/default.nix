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
    ./ardour.nix
    ./bruno.nix
    ./gimp.nix
    ./kdenlive.nix
    ./libreoffice.nix
    ./nheko.nix
    ./peazip.nix
    ./steam.nix
    ./thunar.nix
    ./thunderbird.nix
    ./vivaldi.nix
  ];

  config = lib.mkIf config.pi.programs.enable {
    pi.programs = {
      ardour.enable = lib.mkDefault true;
      bruno.enable = lib.mkDefault true;
      gimp.enable = lib.mkDefault true;
      kdenlive.enable = lib.mkDefault true;
      libreoffice.enable = lib.mkDefault true;
      nheko.enable = lib.mkDefault true;
      peazip.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault (!config.pi.work.enable);
      thunar.enable = lib.mkDefault true;
      thunderbird.enable = lib.mkDefault true;
      vivaldi.enable = lib.mkDefault true;
    };
  };
}
