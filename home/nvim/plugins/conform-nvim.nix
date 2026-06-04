{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.conform-nvim.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.conform-nvim.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings =
          let
            prettier = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
          in
          {
            formatters_by_ft = {
              php = [ "php_cs_fixer" ];
              javascript = prettier;
              typescript = prettier;
              json = prettier;
              scss = prettier;
              css = prettier;
              yaml = prettier;
              lua = [ "stylua" ];
              nix = [ "nixfmt" ];
              qml = [ "qmlformat" ];
              rust = [ "rustfmt" ];
              # "*" = [ "codespell" ];
              # "_" = [ "trim_whitespace" ];
            };
          };
      };
    };
  };
}
