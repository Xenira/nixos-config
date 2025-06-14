{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.comment.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.comment.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.comment = {
    enable = true;
  };
    };
  };
}
