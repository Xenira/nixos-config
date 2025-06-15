{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.shell = {
    enable = lib.mkEnableOption "Enable Shell configuration";
  };

  imports = [
    ./zsh.nix
    ./kitty.nix
    ./tools
  ];

  config = lib.mkIf config.pi.shell.enable {
    pi.shell = {
      zsh.enable = lib.mkDefault config.pi.shell.enable;
      kitty.enable = lib.mkDefault config.pi.shell.enable;
      tools.enable = lib.mkDefault config.pi.shell.enable;
    };
  };
}
