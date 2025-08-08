{ pkgs, ... }:

{
  imports = [
    ./dev
    ./hypr
    ./niri
    ./work
    ./programs
    ./nvim
    ./shell
    ./git.nix
    ./ssh.nix
    ./xdg.nix
  ];

  home-manager.users.ls = {
    programs.home-manager.enable = true;
    fonts.fontconfig.enable = true;
    home.stateVersion = "24.11";
  };
}
