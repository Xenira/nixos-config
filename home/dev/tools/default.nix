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
    ./valgrind.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.dev.tools = {
      valgrind.enable = lib.mkDefault cfg.enable;
    };
  };
}
