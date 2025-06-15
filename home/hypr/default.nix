{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.hypr = {
    enable = lib.mkEnableOption "Enable Hyprland configuration";
  };

  imports = [
    ./hyprlock.nix
    ./hyprland.nix
    ./hypridle.nix
    ./waybar.nix
  ];

  config = lib.mkIf config.pi.hypr.enable {
    pi.hypr = {
      hyprland.enable = config.pi.hypr.enable;
      hyprlock.enable = lib.mkDefault config.pi.hypr.enable;
      hypridle.enable = lib.mkDefault config.pi.hypr.enable;
      waybar.enable = lib.mkDefault config.pi.hypr.enable;
    };
  };
}
