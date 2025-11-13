{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.tools.php-semver-checker;
  phpSemverChecker = pkgs.stdenv.mkDerivation rec {
    pname = "php-semver-checker";
    version = "0.17.0";
    src = pkgs.fetchurl {
      url = "https://github.com/tomzx/php-semver-checker/releases/download/v${version}/php-semver-checker.phar";
      sha256 = "sha256:a00adcb2ca3b5106787bf33e67d1bd2482c6903ffce376ae5f10525ad86c0ef7";
    };
    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cp ${src} $out/bin/php-semver-checker.phar
      chmod +x $out/bin/php-semver-checker.phar
      makeWrapper $out/bin/php-semver-checker.phar $out/bin/php-semver-checker
    '';
  };
in
{
  options.pi.dev.tools.php-semver-checker.enable = lib.mkEnableOption "Enable php-semver-checker";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = [
      phpSemverChecker
    ];
  };
}
