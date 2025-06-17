{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.lang;
in
{
  options.pi.dev.lang = {
    enable = lib.mkEnableOption "Enable Language configuration";
  };

  imports = [
    ./node.nix
    ./php.nix
    ./rust.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.dev.lang = {
      node.enable = lib.mkDefault cfg.enable;
      php.enable = lib.mkDefault cfg.enable;
      rust.enable = lib.mkDefault cfg.enable;
    };
  };
}
