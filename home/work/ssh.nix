{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:

let
  cfg = config.pi.work.ssh;
  username = lib.toLower "${secrets.personal.work.company}-${secrets.personal.first_name}.${secrets.personal.last_name}";
in
{
  options.pi.work.ssh.enable = lib.mkEnableOption "Enable work-related SSH configuration";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls =
      { lib, ... }:
      {
        programs.ssh = {
          matchBlocks = {
            "${secrets.personal.work.vm}" = lib.hm.dag.entryBefore [ "*.${secrets.personal.work.domain_dev}" ] {
              hostname = secrets.personal.work.vm;
              user = "root";
              remoteForwards = [
                {
                  bind.port = 9009;
                  host.address = "localhost";
                  host.port = 9009;
                }
                {
                  bind.port = 5432;
                  host.address = "localhost";
                  host.port = 5432;
                }
              ];
            };
            "dev2" = {
              hostname = "dev2.${secrets.personal.work.domain}";
            };
            "dev3" = {
              hostname = "dev3.${secrets.personal.work.domain}";
            };
            "unstable" = {
              hostname = "unstable.${secrets.personal.work.domain_dev}";
            };
            "testing" = {
              hostname = "testing.${secrets.personal.work.domain_dev}";
            };
            "stable" = {
              hostname = "stable.${secrets.personal.work.domain_dev}";
            };
            "*.${secrets.personal.work.domain_dev}" = {
              user = username;
            };
            "*.${secrets.personal.work.domain}" = {
              user = username;
            };
            "*.${secrets.personal.work.domain_test}" = {
              user = username;
            };
          };
        };
      };
  };
}
