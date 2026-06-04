{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools.cargo-binstall;
in
{
  options.pi.dev.lang.rust.tools.cargo-binstall = {
    enable = lib.mkEnableOption "Cargo Binstall - A tool to install prebuilt binaries of Rust programs from GitHub releases.";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        cargo-binstall
      ];
    };
  };
}
