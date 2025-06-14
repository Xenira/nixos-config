{ pkgs, lib, config, ... }:

{
  options.pi.dev.lang.node = {
    enable = lib.mkEnableOption "Enable Node.js configuration";
  };

  config = lib.mkIf config.pi.dev.lang.node.enable {
    home-manager.users.ls = {
      # set NODE_OPTIONS to increase the memory limit for Node.js processes
      home.sessionVariables.NODE_OPTIONS = "--max-old-space-size=4096"; # 4 GB
      programs.bun.enable = true;
    };

    users.users.ls.packages = with pkgs; [
      nodejs
    ];
  };
}
