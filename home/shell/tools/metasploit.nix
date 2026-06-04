{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.metasploit;
in
{
  options.pi.shell.tools.metasploit = {
    enable = lib.mkEnableOption "Enable metasploit tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        metasploit
      ];
    };
  };
}
