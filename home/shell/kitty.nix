{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.shell.kitty = {
    enable = lib.mkEnableOption "Enable Kitty terminal configuration";
  };

  config = lib.mkIf config.pi.shell.kitty.enable {
    home-manager.users.ls = {
      programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        font = {
          name = "FiraCode Nerd Font Mono";
          package = pkgs.nerd-fonts.fira-code;
        };
        settings = {
          include = lib.mkIf (config.pi.shell.tools.wallust.enable) "~/.config/wallust/templates/kitty.conf";
          enable_audio_bell = false;
          disable_ligatures = "never";
          tab_powerline_style = "slanted";
          tab_bar_style = "powerline";
          tab_bar_edge = "bottom";
          tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
          tab_bar_min_tabs = 1;
          cursor_shape = "block";
          notify_on_cmd_finish = "unfocused";

          scrollback_lines = 50000;
        };
        themeFile = lib.mkIf (!config.pi.shell.tools.wallust.enable) "Catppuccin-Mocha";
      };
    };

    environment.pathsToLink = [ "/share/zsh" ];
  };
}
