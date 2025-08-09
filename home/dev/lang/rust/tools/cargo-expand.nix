{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools.cargo-expand;
in
{
  options.pi.dev.lang.rust.tools.cargo-expand = {
    enable = lib.mkEnableOption "Cargo MSRV";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        cargo-expand
      ];
    };
  };
}
