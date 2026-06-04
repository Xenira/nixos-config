{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools.intelli-shell;
in
{
  options.pi.shell.tools.intelli-shell = {
    enable = lib.mkEnableOption "Enable intelli-shell configuration";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs = {
        intelli-shell = {
          enable = true;
          enableZshIntegration = config.pi.shell.zsh.enable;
          enableBashIntegration = true;
          settings = {
            check_updates = false;
          };
        };
      };
    };
  };
}
