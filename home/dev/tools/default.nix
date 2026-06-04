{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.tools;
in
{
  options.pi.dev.tools.enable = lib.mkEnableOption "Enable dev tools";

  imports = [
    ./php-semver-checker.nix
    ./scc.nix
    ./tilt.nix
    ./valgrind.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.dev.tools = {
      php-semver-checker.enable = lib.mkDefault true;
      scc.enable = lib.mkDefault true;
      tilt.enable = lib.mkDefault true;
      valgrind.enable = lib.mkDefault true;
    };
  };
}
