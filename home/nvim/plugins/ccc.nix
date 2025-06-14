{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.ccc.enable = lib.mkEnableOption "Enable this plugin";

  config = lib.mkIf config.pi.nvim.plugins.ccc.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.ccc = {
    enable = true;
  };
  };
  };
}
