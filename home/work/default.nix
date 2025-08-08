{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.work;
in
{
  options.pi.home.work.enable = lib.mkEnableOption "Enable workrelated configuration";

  imports = [
    ./cli.nix
    ./ssh.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.home.work.cli.enable = lib.mkDefault cfg.enable;
    pi.work.ssh.enable = lib.mkDefault cfg.enable;

    networking.networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
  };
}
