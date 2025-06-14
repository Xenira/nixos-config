{ pkgs, ... }:

{
  imports = [
    ./dev
    ./hypr
    ./work
    ./programs
    ./nvim
    ./shell
    ./git.nix
    ./xdg.nix
  ];

  home-manager.users.ls = {
    programs.home-manager.enable = true;
    fonts.fontconfig.enable = true;
    home.stateVersion = "24.11";
  };
}
