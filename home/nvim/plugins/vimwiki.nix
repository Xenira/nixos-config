{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.vimwiki.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.vimwiki.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins = {
        vimwiki = {
          enable = true;
        };
        cmp-vimwiki-tags = lib.mkIf config.pi.nvim.plugins.cmp.enable {
          enable = true;
        };
        cmp = lib.mkIf config.pi.nvim.plugins.cmp.enable {
          settings.sources = [
            {
              name = "vimwiki-tags";
            }
          ];
        };
      };
    };
  };
}
