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
              xsl
            ])
          );
          embedSupport = true;
        };
        phpstanm = pkgs.phpstan.override {
          php = phpm;
        };
        php_version_int = lib.toInt cfg.version;
        phpunitm = pkgs.phpunit.override {
          php = if php_version_int <= 83 then pkgs.php else phpm;
        };
      in
      [
        phpm
        phpm.packages.composer
        phpstanm
        phpm.packages.psalm
        phpm.packages.php-cs-fixer
        # phpunit needs PHP 8.3+
        phpunitm
        # phpm.packages.php-unit
        phpm.packages.box
        # phpunit.
        # php83Packages.php-cs-fixer
        # phpactor
      ];
  };
}
