{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.auto-session.enable = lib.mkEnableOption "Enables the plugin";

  config = lib.mkIf config.pi.nvim.plugins.auto-session.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.auto-session = {
        enable = true;
        settings.use_git_branch = true;
      };
    };
  };
}
