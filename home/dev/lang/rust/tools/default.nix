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
    ./cargo-binstall.nix
    ./cargo-edit.nix
    ./cargo-expand.nix
    ./cargo-generate.nix
    ./cargo-machete.nix
    ./cargo-msrv.nix
    ./cargo-tarpaulin.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.dev.lang.rust.tools = {
      bacon.enable = lib.mkDefault true;
      cargo-binstall.enable = lib.mkDefault true;
      cargo-edit.enable = lib.mkDefault true;
      cargo-expand.enable = lib.mkDefault true;
      cargo-generate.enable = lib.mkDefault true;
      cargo-machete.enable = lib.mkDefault true;
      cargo-msrv.enable = lib.mkDefault true;
      cargo-tarpaulin.enable = lib.mkDefault true;
    };
  };
}
