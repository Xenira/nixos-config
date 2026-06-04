{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.nvim.plugins.overseer;
  nvo = [
    "n"
    "v"
    "o"
  ];
in
{
  options.pi.nvim.plugins.overseer = {
    enable = lib.mkEnableOption "Enable overseer plugin";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim = {
        keymaps = [
        ];

        plugins.overseer = {
          enable = true;
        };
      };
    };
  };
}
