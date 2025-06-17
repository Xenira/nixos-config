{
  pkgs,
  lib,
  config,
  secrets,
  ...
}:

let
  cfg = config.pi.programs.thunderbird;
  real_name = secrets.personal.first_name + " " + secrets.personal.last_name;
  user_name = lib.toLower (lib.replaceStrings [ " " ] [ "." ] real_name);
  map_calendar =
    calendar:
    let
      safeName = builtins.replaceStrings [ "." ] [ "-" ] calendar.name;
    in
    {
      "calendar.registry.${safeName}.cache.enabled" = true;
      "calendar.registry.${safeName}.calendar-main-default" = calendar.primary;
      "calendar.registry.${safeName}.calendar-main-in-composite" = calendar.primary;
      "calendar.registry.${safeName}.name" = calendar.name;
      "calendar.registry.${safeName}.type" = "caldav";
      "calendar.registry.${safeName}.uri" = calendar.remote.url;
      "calendar.registry.${safeName}.username" = calendar.remote.userName;
    };
  cal_settings =
    let
      cal = map (map_calendar) (
        builtins.attrValues config.home-manager.users.ls.accounts.calendar.accounts
      );
    in
    builtins.foldl' lib.recursiveUpdate { } cal;
in
{
  options.pi.programs.thunderbird.enable = lib.mkEnableOption "Enable Thunderbird configuration";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.thunderbird = {
        enable = true;

        profiles = {
          work = {
            isDefault = lib.mkDefault config.pi.work.enable;
          };
          personal = {
            isDefault = !config.pi.work.enable;
          };
        };

        settings = {
          "privacy.donottrackheader.enabled" = true;
        };
      };

      xdg = {
        mimeApps = {
          defaultApplications = {
            "x-scheme-handler/mailto" = "thunderbird.desktop";
          };
        };
      };

      accounts = {
        email.accounts = {
          work = {
            address = secrets.personal.work.email;
            realName = real_name;
            thunderbird.enable = true;
            primary = true;
            imap = {
              host = secrets.personal.work.host;
              port = 993;
            };
            userName = user_name;
          };
          vm = {
            address = user_name + "@" + secrets.personal.work.vm;
            realName = real_name;
            thunderbird.enable = true;
            imap = {
              host = secrets.personal.work.vm;
              port = 993;
            };
            userName = user_name;
          };
        };

        calendar.accounts = {
          "${real_name} (wrk)" = {
            primary = true;
            remote = {
              userName = user_name;
              url = "https://" + secrets.personal.work.host + "/caldav/" + user_name + "/home/";
              type = "caldav";
            };
            thunderbird = {
              enable = true;
              profiles = [
                "personal"
                "work"
              ];
            };
          };
          "PB:GK (wrk)" = {
            primary = false;
            remote = {
              userName = user_name;
              url =
                "https://"
                + secrets.personal.work.host
                + "/caldav/"
                + secrets.personal.work.company
                + ".entwicklung.pb.gk/calendar/";
              type = "caldav";
            };
            thunderbird = {
              enable = true;
              profiles = [
                "personal"
                "work"
              ];
            };
          };
        };
      };
    };
  };
}
