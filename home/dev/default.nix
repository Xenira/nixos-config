{ config, lib, pkgs, ... }:

{
  options.pi.dev = {
    enable = lib.mkEnableOption "Enable Development Environment configuration";
  };

  imports = [
    ./lang
  ];

  config = lib.mkIf config.pi.dev.enable {
    pi.dev = {
      lang.enable = lib.mkDefault config.pi.dev.enable;
    };
  };
}
