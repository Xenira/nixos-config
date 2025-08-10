{
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    ./config.nix
    ./home
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.useTmpfs = true;
  };
  environment = {
    systemPackages =
      with pkgs;
      let
        phpm = php82.buildEnv {
          extraConfig = "memory_limit = 4G";
          extensions = (
            { enabled, all }:
            enabled
            ++ (with all; [
              amqp
              ds
              redis
              mailparse
              xdebug
              yaml
            ])
          );
        };
      in
      [
        # We always want to have git, as it is needed to rebuild the system.
        git

        # Old config, needs to be migrated
        delta
        convco
        nmap
        dive

        bash
        jq
        silver-searcher
        ripgrep
        wl-clipboard
        zip
        unzip
        tldr
        lefthook
        # jujutsu
        # lazyjj

        pkg-config
        openssl

        librewolf
        # firefox
        chromium
        bruno

        keepassxc
        obs-studio
        kdePackages.kdenlive
        vlc
        mpv
        gimp
        usbimager
        pavucontrol

        rustup
        zig
        clang
        libclang
        gcc
        gnumake
        autoconf
        bison
        re2c

        dart-sass
        typos

        go
        python3
        python3Packages.pip
        prettierd
        # lua
        # luaPackages.luarocks
        lua51Packages.lua
        lua51Packages.luarocks
        stylua

        fastfetch
        eza
        uxplay

        nnn
        bat
        fzf
        zoxide

        # gnome keyring system prompt
        gcr

        # Hyprland
        hyprpicker
        dunst
        hyprshot
        tofi
        networkmanagerapplet

        xfce.thunar

        yubioath-flutter
        qMasterPassword-wayland
        showmethekey

        presenterm
        mermaid-cli
        dconf
      ];
    variables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  hardware = lib.mkIf config.pi.desktop.enable {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  security = {
    pam = {
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
      u2f.settings = {
        cue = true;
      };
    };
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ls = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout"
      "audio"
    ];
    packages = with pkgs; [ ];
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services = {
    udev = {
      packages = with pkgs; [
        yubikey-personalization
        libu2f-host
      ];
      extraRules = ''
        ACTION=="remove",\
         ENV{ID_BUS}=="usb",\
         ENV{ID_MODEL_ID}=="0407",\
         ENV{ID_VENDOR_ID}=="1050",\
         ENV{ID_VENDOR}=="Yubico",\
         RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';

    };
    pcscd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    gnome.at-spi2-core.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts-emoji
  ];
  fonts.fontconfig.defaultFonts = {
    emoji = [ "Noto Color Emoji" ];
  };
  fonts.enableDefaultPackages = true;

  system.activationScripts.binbash = {
    deps = [
      "binsh"
    ];
    text = ''
      ln -sf /run/current-system/sw/bin/bash /bin/bash
    '';
  };

  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = lib.mkIf config.pi.work.enable {
        bip = "192.18.0.1/24";
        default-address-pools = [
          {
            base = "192.18.0.1/16";
            size = 24;
          }
        ];
      };
    };

  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  nix.gc = {
    automatic = !config.pi.shell.tools.nh.enable;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
}
