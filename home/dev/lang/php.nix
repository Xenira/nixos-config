{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.lang.php;
in
{
  options.pi.dev.lang.php = {
    enable = lib.mkEnableOption "php";
    version = lib.mkOption {
      default = "84";
      type = lib.types.str;
    };
  };

  config = {
    users.users.ls.packages =
      with pkgs;
      let
        phpm = pkgs."php${cfg.version}".buildEnv {
          extraConfig = "memory_limit = 4G";
          extensions = (
            { enabled, all }:
            enabled
            ++ (with all; [
              amqp
              bz2
              ds
              redis
              mailparse
              xdebug
              yaml
            ])
          );
          embedSupport = true;
        };
      in
      [
        phpm
        phpm.packages.composer
        phpm.packages.phpstan
        phpm.packages.box
        # phpm.packages.php-cs-fixer
        php83Packages.php-cs-fixer
        # php82Extensions.amqp
        # php82Extensions.redis
        # phpactor
      ];
  };
}
