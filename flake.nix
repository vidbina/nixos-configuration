# https://nixos.wiki/wiki/Flakes
{
  description = "System configurations for David Asabina";

  inputs = {
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixos-21.05;
    };

    nixos-hardware = {
      url = github:NixOS/nixos-hardware/master;
    };

    home-manager = {
      url = github:nix-community/home-manager/release-21.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = github:nix-community/emacs-overlay;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , emacs-overlay
    } @ args:
    let
      # TODO: Use flake-utils to do this well
      mkLinuxSystem = { target, module }: nixpkgs.lib.nixosSystem {
        #inherit system;
        system = "x86_64-linux";
        modules = [
          #nixos-hardware.nixosModules."${module}"
          ./base.nix
          (./. + "/targets/${target}/hardware-configuration.nix")
          (./. + "/targets/${target}/custom.nix")


          home-manager.nixosModules.home-manager

          # Infuse config/dotfile flakes
          # NOTE: Define after importing users.nix (because of my-config dep)
          ({ config, lib, ... }: {
            config.home-manager = {
              users = (lib.genAttrs [ config.my-config.handle ] (username: {
                home = { };
              }));
            };

            config.nixpkgs.overlays = [
              (import emacs-overlay)
            ];
          })
        ];
      };
      targets = [ "dell-xps-9360" "dell-precision-5560" ];
      hardwareModules = {
        dell-xps-9360 = nixos-hardware.nixosModules.dell-xps-13-9360;
        dell-precision-5560 = nixos-hardware.nixosModules.dell-precision-5530;
      };
    in
    {
      nixosConfigurations = (nixpkgs.lib.genAttrs targets (target: mkLinuxSystem {
        inherit target;
        module = hardwareModules."${target}";
      }));
    };
}
