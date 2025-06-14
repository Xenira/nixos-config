{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.markdown-preview.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.markdown-preview.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      auto_close = 1;
      theme = "dark";
    };
  };
    };
  };
}
