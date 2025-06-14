{ config, lib, pkgs, ... }:

let
  cfg = config.pi.shell.tools;
in {
  options.pi.shell.tools = {
    enable = lib.mkEnableOption "Enable Shell Tools configuration";
  };

  imports = [
    ./git-crypt.nix
    ./nh.nix
    ./clipboard.nix
    ./sops.nix
    ./top.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.shell.tools = {
      git_crypt.enable = lib.mkDefault cfg.enable;
      nh.enable = lib.mkDefault cfg.enable;
      clipboard.enable = lib.mkDefault cfg.enable;
      sops.enable = lib.mkDefault cfg.enable;
      top.enable = lib.mkDefault cfg.enable;
    };
  };
}
