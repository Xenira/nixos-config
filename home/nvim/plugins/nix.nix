{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.nix.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.nix.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.nix = {
        enable = true;
      };
    };
  };
}
