{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.copilot-lua.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.copilot-lua.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        auto_trigger = true;
        keymap = {
          accept = "<C-CR>";
          accept_word = "<S-CR>";
        };
      };
      filetypes = {
        "*" = true;
      };
    };
  };
    };
  };
}
