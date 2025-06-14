{ config, lib, pkgs, ... }:

{
  options.pi.nvim.plugins.telescope.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.telescope.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzy-native.enable = true;
    };
    settings = {
      defaults = {
        layout_strategy = "vertical";
        layout_config = {
          prompt_position = "bottom";
          preview_height = 0.7;
        };
      };
    };
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
    };
  };
    };
  };
}
