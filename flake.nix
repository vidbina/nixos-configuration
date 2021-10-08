# https://nixos.wiki/wiki/Flakes
{
  description = "System configurations for David Asabina";

  inputs = {
    nixpkgs = {
      url = github:vidbina/nixpkgs/current-21.05;
    };

    nixos-hardware = {
      url = github:NixOS/nixos-hardware/master;
    };

    home-manager = {
      url = github:nix-community/home-manager/release-21.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    } @ args:
    {
      nixosConfigurations = {
        dell-xps-9360 = nixpkgs.lib.nixosSystem {
          #inherit system;
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.dell-xps-13-9360
            ./targets/dell-xps-9360/hardware-configuration.nix

            ./base.nix

            home-manager.nixosModules.home-manager

            # Infuse config/dotfile flakes
            # NOTE: Define after importing users.nix (because of my-config dep)
            ({ config, lib, ... }: {
              config.home-manager = {
                users = (lib.genAttrs [ config.my-config.handle ] (username: {
                  home = {
                  };
                }));
              };
            })
          ];

        };
      };
    };
}
