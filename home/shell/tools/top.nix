{ pkgs, lib, config, ... }:

{
  options.pi.shell.tools.top = {
    enable = lib.mkEnableOption "Enable Top configuration";
  };

  config = lib.mkIf config.pi.shell.tools.top.enable {
    home-manager.users.ls = {
      programs.btop.enable = true;
      programs.htop.enable = true;
    };
  };
}
