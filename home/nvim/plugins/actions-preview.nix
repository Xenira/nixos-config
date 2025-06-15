{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.actions-preview = {
    enable = lib.mkEnableOption "Enable actions-preview plugin for Neovim";
  };

  config = lib.mkIf (config.pi.nvim.enable && config.pi.nvim.plugins.actions-preview.enable) {
    home-manager.users.ls = {
      programs.nixvim.plugins.actions-preview = {
        enable = true;
        settings = {
          # highlight_command = [
          #   (lib.nixvim.mkRaw "require('actions-preview.highlight').delta 'delta --side-by-side'")
          #   (lib.nixvim.mkRaw "require('actions-preview.highlight').diff_so_fancy()")
          #   (lib.nixvim.mkRaw "require('actions-preview.highlight').diff_highlight()")
          # ];
          telescope = {
            layout_config = {
              height = 0.9;
              preview_cutoff = 20;
              #       preview_height = (lib.nixvim.mkRaw ''
              #   function(_, _, max_lines)
              #     return max_lines - 15
              #   end
              # '');
              prompt_position = "top";
              width = 0.8;
            };
            layout_strategy = "vertical";
            sorting_strategy = "ascending";
          };
        };
      };
    };
  };
}
