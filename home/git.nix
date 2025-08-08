{
  pkgs,
  lib,
  config,
  secrets,
  ...
}:

let
  user_config =
    if config.pi.work.enable then
      {
        userEmail = secrets.personal.work.email;
        userName = secrets.personal.first_name + " " + secrets.personal.last_name;

        signing = {
          key = "6EF3F94BCA9A46C5";
          format = "openpgp";
        };
      }
    else
      {
        userName = "Xenira";
        userEmail = "1288524+Xenira@users.noreply.github.com";

        signing = {
          key = "~/.ssh/github_sign_id_ed25519";
          format = "ssh";
        };
      };
in
{
  options.pi.git = {
    enable = lib.mkEnableOption "Enable Hypridle configuration";
  };

  config = lib.mkIf config.pi.git.enable {
    home-manager.users.ls = {
      programs = {
        git = lib.mkMerge [
          {
            enable = true;

            lfs.enable = true;

            delta = {
              enable = true;
            };

            signing.signByDefault = true;

            extraConfig = {
              # core.editor = lib.mkIf config.pi.nvim.enable "nvim";
              core.editor = "nvim";
              init.defaultBranch = "master";
              merge.conflictStyle = "diff3";
              push.autoSetupRemote = true;
            };
          }
          user_config
        ];
        gh = {
          enable = true;
          settings = {
            git_protocol = "ssh";
          };
        };
        ssh.matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/github_id_ed25519";
          };
          "${secrets.personal.work.git_host}" = lib.mkIf config.pi.work.enable {
            hostname = secrets.personal.work.git_host;
            user = "git";
            identityFile = "~/.ssh/gitlab2025_id_ed25519";
          };
        };
      };
    };
  };
}
