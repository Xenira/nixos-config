{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.nvim-tree.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.nvim-tree.enable {
    home-manager.users.ls = {
      programs.nixvim = {
        plugins.nvim-tree = {
          enable = true;
          openOnSetup = true;
          sortBy = "case_sensitive";
          view = {
            width = 30;
          };
          renderer = {
            groupEmpty = true;
          };
          filters = {
            dotfiles = true;
          };
          updateFocusedFile.enable = true;
          diagnostics = {
            enable = true;
            showOnDirs = true;
          };
          modified.enable = true;
          reloadOnBufenter = true;
        };
        keymaps = [
          {
            mode = [
              "n"
              "v"
              "o"
            ];
            key = "<leader>e";
            action = "<cmd>NvimTreeToggle<cr>";
          }
        ];
      };
    };
  };
}
