{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.gitsigns.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.gitsigns.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.gitsigns = {
    enable = true;
  };
    };
  };
}
