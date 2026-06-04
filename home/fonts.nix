{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.font;
in
{
  options.pi.font.enable = lib.mkEnableOption "Enable font configuration";

  config = lib.mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.fira-code
        noto-fonts-color-emoji
        xkcd-font
      ];
      enableDefaultPackages = true;
    };

    home-manager.users.ls = {
      fonts.fontconfig = {
        enable = true;
        antialiasing = true;

        defaultFonts = {
          monospace = [ "FiraCode Nerd Font Mono" ];
          serif = [ "FiraCode Nerd Font" ];
          sansSerif = [ "FiraCode Nerd Font" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
