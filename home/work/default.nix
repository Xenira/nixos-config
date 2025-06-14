{ config, lib, ... }:

let
  cfg = config.pi.work;
in {
  options.pi.home.work.enable = lib.mkEnableOption "Enable workrelated configuration";

  imports = [
    ./cli.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.home.work.cli.enable = lib.mkDefault cfg.enable;
  };
}
