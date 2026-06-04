{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools.cargo-machete;
in
{
  options.pi.dev.lang.rust.tools.cargo-machete = {
    enable = lib.mkEnableOption "Cargo machete - Remove unused Rust dependencies with this one weird trick!";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        cargo-machete
      ];
    };
  };
}
