{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust;
in
{
  options.pi.dev.lang.rust = {
    enable = lib.mkEnableOption "Enable Rust development environment";
  };

  imports = [
    ./tools
  ];

  config = lib.mkIf cfg.enable {
    pi.dev.lang.rust = {
      tools.enable = lib.mkDefault cfg.enable;
    };
  };
}
