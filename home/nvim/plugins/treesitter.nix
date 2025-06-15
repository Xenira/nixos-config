{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.treesitter.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.treesitter.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "lua"
            "rust"
            "toml"
            "json"
            "javascript"
            "typescript"
            "python"
            "css"
            "dockerfile"
            "gitignore"
            "gitattributes"
            "html"
            "markdown"
            "scss"
            "sql"
            "php"
            "twig"
          ];
          auto_install = true;
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent.enable = true;
        };
      };
    };
  };
}
