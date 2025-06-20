{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.nvim.plugins.neotest;
in
{
  options.pi.nvim.plugins.neotest = {
    enable = lib.mkEnableOption "Enable Neotest plugin";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.neotest = {
        enable = true;
        adapters = {
          bash.enable = true;
          playwright.enable = true;
          plenary.enable = true;
          rust.enable = true;
          vitest.enable = true;
        };
      };
    };
  };
}
