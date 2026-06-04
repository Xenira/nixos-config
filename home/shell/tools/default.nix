{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools;
in
{
  options.pi.shell.tools = {
    enable = lib.mkEnableOption "Enable Shell Tools configuration";
  };

  imports = [
    ./clipboard.nix
    ./dig.nix
    ./fastfetch.nix
    ./flamelens.nix
    ./git-crypt.nix
    ./inotify-tools.nix
    ./itelli-shell.nix
    ./killall.nix
    ./lychee.nix
    ./metasploit.nix
    ./ncdu.nix
    ./nh.nix
    ./openapi-tui.nix
    ./parallel.nix
    ./ripgrep.nix
    ./sops.nix
    ./syft.nix
    ./tailspin.nix
    ./top.nix
    ./traceroute.nix
    ./wallust
    ./yq.nix
    ./yubico-piv-tool.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.shell.tools = {
      clipboard.enable = lib.mkDefault true;
      dig.enable = lib.mkDefault true;
      fastfetch.enable = lib.mkDefault true;
      flamelens.enable = lib.mkDefault true;
      git_crypt.enable = lib.mkDefault true;
      inotify-tools.enable = lib.mkDefault false;
      intelli-shell.enable = lib.mkDefault true;
      killall.enable = lib.mkDefault false;
      lychee.enable = lib.mkDefault true;
      metasploit.enable = lib.mkDefault true;
      ncdu.enable = lib.mkDefault true;
      nh.enable = lib.mkDefault true;
      openapi-tui.enable = lib.mkDefault true;
      parallel.enable = lib.mkDefault true;
      ripgrep.enable = lib.mkDefault true;
      sops.enable = lib.mkDefault true;
      syft.enable = lib.mkDefault true;
      tailspin.enable = lib.mkDefault true;
      top.enable = lib.mkDefault true;
      traceroute.enable = lib.mkDefault true;
      wallust.enable = lib.mkDefault true;
      yq.enable = lib.mkDefault true;
      yubico-piv-tool.enable = lib.mkDefault true;
    };
  };
}
