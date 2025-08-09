{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools;
in
{
  options.pi.dev.lang.rust.tools = {
    enable = lib.mkEnableOption "Rust tools";
  };

  imports = [
    ./bacon.nix
    ./cargo-expand.nix
    ./cargo-generate.nix
    ./cargo-msrv.nix
    ./cargo-tarpaulin.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.dev.lang.rust.tools = {
      bacon.enable = lib.mkDefault cfg.enable;
      cargo-expand.enable = lib.mkDefault cfg.enable;
      cargo-generate.enable = lib.mkDefault cfg.enable;
      cargo-msrv.enable = lib.mkDefault cfg.enable;
      cargo-tarpaulin.enable = lib.mkDefault cfg.enable;
    };
  };
}
