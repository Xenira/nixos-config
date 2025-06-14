{ config, lib, pkgs, ... }:

let
  cfg = config.pi.shell.tools.git_crypt;
in {
  options.pi.shell.tools.git_crypt.enable = lib.mkEnableOption "git-crypt";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git-crypt
    ];
  };
}
