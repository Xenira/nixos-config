{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools;
in
{
  options.pi.shell.tools = {
    enable = lib.mkEnableOption "Enable Shell Tools configuration";
  };

  imports = [
    ./wallust
    ./clipboard.nix
    ./dig.nix
    ./fastfetch.nix
    ./git-crypt.nix
    ./inotify-tools.nix
    ./killall.nix
    ./ncdu.nix
    ./nh.nix
    ./ripgrep.nix
    ./sops.nix
    ./top.nix
    ./traceroute.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.shell.tools = {
      wallust.enable = lib.mkDefault true;
      clipboard.enable = lib.mkDefault cfg.enable;
      dig.enable = lib.mkDefault cfg.enable;
      fastfetch.enable = lib.mkDefault cfg.enable;
      git_crypt.enable = lib.mkDefault cfg.enable;
      inotify-tools.enable = lib.mkDefault false;
      killall.enable = lib.mkDefault false;
      ncdu.enable = lib.mkDefault cfg.enable;
      nh.enable = lib.mkDefault cfg.enable;
      ripgrep.enable = lib.mkDefault cfg.enable;
      sops.enable = lib.mkDefault cfg.enable;
      top.enable = lib.mkDefault cfg.enable;
      traceroute.enable = lib.mkDefault cfg.enable;
    };
  };
}
