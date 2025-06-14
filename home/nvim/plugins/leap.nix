{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.leap.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.leap.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.leap = {
    enable = true;
  };
    };
  };
}
