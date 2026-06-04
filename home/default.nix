{ pkgs, ... }:

{
  imports = [
    ./dev
    ./fonts.nix
    ./git.nix
    ./hypr
    ./niri
    ./nvim
    ./programs
    ./qs
    ./shell
    ./ssh.nix
    ./work
    ./xdg.nix
  ];

  home-manager.users.ls = {
    programs.home-manager.enable = true;
    fonts.fontconfig.enable = true;
    home.stateVersion = "24.11";
  };
}
