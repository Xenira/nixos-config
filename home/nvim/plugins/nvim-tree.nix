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
          # autoClose = true;
          openOnSetup = true;

          settings = {
            view = {
              width = 30;
            };
            renderer = {
              groupEmpty = true;
            };
            filters = {
              dotfiles = true;
            };
            diagnostics = {
              enable = true;
              showOnDirs = true;
            };
            sortBy = "case_sensitive";
            updateFocusedFile.enable = true;
            modified.enable = true;
            reloadOnBufenter = true;
          };
        };
        autoCmd = [
          {
            event = "BufEnter";
            nested = true;
            callback = {
              __raw = ''
                function()
                  if not require("nvim-tree.utils").is_nvim_tree_buf() then
                    require("nvim-tree.api").tree.close()
                  end
                end
              '';
            };
          }
        ];
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
