{ config, lib, pkgs, nixvim, ... }:

{
  options.pi.nvim.enable = lib.mkEnableOption "Enable Neovim Configuration";

  imports = [
    ./nvim.nix
  ];

  config = lib.mkIf config.pi.nvim.enable {
    home-manager.users.ls = {
      imports = [
        nixvim.homeModules.nixvim
      ];
    };
  };
}
