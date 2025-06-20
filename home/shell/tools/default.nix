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
    ./clipboard.nix
    ./fastfetch.nix
    ./git-crypt.nix
    ./nh.nix
    ./ripgrep.nix
    ./sops.nix
    ./top.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.shell.tools = {
      clipboard.enable = lib.mkDefault cfg.enable;
      fastfetch.enable = lib.mkDefault cfg.enable;
      git_crypt.enable = lib.mkDefault cfg.enable;
      nh.enable = lib.mkDefault cfg.enable;
      ripgrep.enable = lib.mkDefault cfg.enable;
      sops.enable = lib.mkDefault cfg.enable;
      top.enable = lib.mkDefault cfg.enable;
    };
  };
}
