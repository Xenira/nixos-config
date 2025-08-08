{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.ssh;
in
{
  options.pi.ssh.enable = lib.mkEnableOption "Enable SSH configuration";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls.programs.ssh = {
      enable = true;

      controlMaster = "auto";
      controlPath = "~/.ssh/sockets-%r@%h:%p";
      controlPersist = "1h";

      forwardAgent = true;
      serverAliveInterval = 60;
      serverAliveCountMax = 1;
    };
  };
}
