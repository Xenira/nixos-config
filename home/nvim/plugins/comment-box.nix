{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.comment-box.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.comment-box.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.comment-box = {
        enable = true;
      };
    };
  };
}
