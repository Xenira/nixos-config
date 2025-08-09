{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools.cargo-generate;
in
{
  options.pi.dev.lang.rust.tools.cargo-generate = {
    enable = lib.mkEnableOption "Cargo MSRV";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        cargo-generate
      ];
    };
  };
}
