{
  pkgs,
  lib,
  config,
  secrets,
  self,
  ...
}:

let
  updateCmd =
    "rustup update && echo 'Updating NixOS...' "
    + (
      if config.pi.shell.tools.nh.enable then
        " && nh os switch ~/.config/nix --ask --update"
      else
        "&& nix flake update ~/.config/nix && sudo nixos-rebuild switch --flake ~/.config/nix"
    );
in
{
  options.pi.shell.zsh = {
    enable = lib.mkEnableOption "Enable Zsh configuration";
  };

  config = lib.mkIf config.pi.shell.zsh.enable {
    # TODO: make this a user option
    programs.zsh = {
      enable = true;
    };
    users = {
      defaultUserShell = pkgs.zsh;
    };
    environment.shells = with pkgs; [ zsh ];

    home-manager.users.ls = {
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          historySubstringSearch.enable = true;

          shellAliases = {
            ":q" = "exit";
            ":wq" = "exit";
            ":qa" = "exit";
            ":wqa" = "exit";
            ":q!" = "exit";
            ":wq!" = "exit";
            ":qa!" = "exit";
            ":wqa!" = "exit";

            i = lib.mkIf config.pi.home.work.cli.enable config.pi.home.work.cli.cmd;
            f = "find . -iname";
            p = "ps aux | grep";

            nano = "nvim";
            nani = "nvim .";
            vim = "nvim";
            vi = "nvim";

            update = updateCmd;
            # update = "rustup update && echo 'Updating NixOS...' && sudo nix-channel --update && sudo nixos-rebuild switch && sudo nix-collect-garbage --delete-older-than 30d";

            ll = "eza -laag --hyperlink --icons --git --time-style relative --group-directories-first";

            amend = "git commit --amend --no-edit && git push --force-with-lease";

            ssh_dev = lib.mkIf config.pi.work.enable ("ssh -R 9009:localhost:9009 " + secrets.personal.work.vm);
            sshk = lib.mkIf config.pi.shell.kitty.enable "kitty +kitten ssh";
            use_nix = ''echo "use nix" >> .envrc'';
            use_flake = ''echo "use flake" >> .envrc'';
          };

          zplug = {
            enable = true;
            plugins = [
              {
                name = "romkatv/powerlevel10k";
                tags = [
                  "as:theme"
                  "depth:1"
                ];
              }
            ];
          };

          history = {
            size = 10000;
            expireDuplicatesFirst = true;
            findNoDups = true;
          };

          initContent =
            ''
              autoload -U add-zsh-hook
              ls_after_cd() {
                ll --color=always
              }
              add-zsh-hook chpwd ls_after_cd

              export XCURSOR_THEME="catppuccin-mocha-dark-cursors"
              export XCURSOR_SIZE=24
              export NODE_OPTIONS=--max-old-space-size=8192
            ''
            + lib.optionalString config.pi.programs.vivaldi.enable ''
              export BROWSER="${pkgs.vivaldi}/bin/vivaldi";
            ''
            + ''
              dconf write /org/gnome/desktop/interface/cursor-theme "'$XCURSOR_THEME'"
              bindkey "''${key[Up]}" history-substring-search-up
              bindkey "''${key[Down]}" history-substring-search-down
              source ${./.p10k.zsh}
            ''
            + lib.optionalString config.pi.shell.tools.fastfetch.enable ''
              ${pkgs.fastfetch}/bin/fastfetch
            ''
            + lib.optionalString config.pi.home.work.cli.enable ''
              ${config.pi.home.work.cli.cmd} --non-interactive status || true
            '';
        };

        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
      };

      home.shell.enableZshIntegration = true;
      home.sessionPath = [
        "$HOME/.cargo/bin"
      ];

      home.packages = with pkgs; [
        fastfetch
        zoxide
        phinger-cursors
        bibata-cursors
        catppuccin-cursors.mochaDark
        catppuccin-cursors.mochaRed
        catppuccin-cursors.mochaBlue
        catppuccin-cursors.mochaSapphire
        catppuccin-cursors.latteRed
        catppuccin-cursors.latteDark
        catppuccin-cursors.latteLight
      ];
    };
  };
}
