{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.lspkind.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.lspkind.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.lspkind = {
    enable = true;
  };
    };
  };
}
