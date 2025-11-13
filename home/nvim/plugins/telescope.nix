{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.telescope.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.telescope.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.telescope = {
        enable = true;
        extensions = {
          fzy-native.enable = true;
          file-browser = {
            enable = true;
            settings = {
              collapse_dirs = true;
              cwd_to_path = true;
              grouped = true;
            };
          };
          frecency = {
            enable = true;
            settings = {
              max_timestamps = 100;
              show_scores = true;
            };
          };
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
          "<leader>ff" = "frecency workspace=CWD";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fp" = "file_browser path=%:p:h select_buffer=true";
          "<leader>t" = "file_browser path=%:p:h select_buffer=true";
        };
      };
    };
  };
}
