{ config, lib, pkgs, ... }:

{
  options.pi.dev.lang = {
    enable = lib.mkEnableOption "Enable Language configuration";
  };

  imports = [
    ./node.nix
  ];

  config = lib.mkIf config.pi.dev.lang.enable {
    pi.dev.lang.node.enable = lib.mkDefault config.pi.dev.lang.enable;
  };
}
