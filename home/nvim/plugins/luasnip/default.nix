{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.luasnip.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.luasnip.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.luasnip = {
        enable = true;
        fromLua = [ { paths = "${./snippets}"; } ];
      };
    };
  };
}
