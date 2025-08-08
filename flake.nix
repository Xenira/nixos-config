{
  description = "Nix flake for my configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixvim,
      niri,
      ...
    }:
    let
      secrets_file = builtins.readFile "${self}/secrets/secrets.toml";
      #secrets_file = builtins.tryEval (builtins.fromTOML (builtins.readFile "${self}/secrets/secrets.toml"));
      secrets = builtins.fromTOML secrets_file;
      special_args = {
        inherit
          secrets
          inputs
          nixvim
          niri
          self
          ;
      };
    in
    {
      nixosConfigurations = {
        nixos-wrk = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = special_args;
          modules = [
            ./hosts/wrk/configuration.nix
            home-manager.nixosModules.home-manager
            niri.nixosModules.niri
            ./nix.nix
          ];
        };
        pios = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = special_args;
          modules = [
            ./hosts/pi/configuration.nix
            home-manager.nixosModules.home-manager
            niri.nixosModules.niri
            ./nix.nix
          ];
        };
      };
    };
}
