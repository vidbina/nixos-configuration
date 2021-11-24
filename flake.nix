# https://nixos.wiki/wiki/Flakes
{
  description = "System configurations for David Asabina";

  inputs = {
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixos-unstable;
    };

    nixos-hardware = {
      url = github:NixOS/nixos-hardware/master;
    };

    emacs-overlay = {
      url = github:nix-community/emacs-overlay;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
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

          # Infuse config/dotfile flakes
          # NOTE: Define after importing users.nix (because of my-config dep)
          ({ config, lib, ... }: {
            config.networking.hostName = "vidbina-${target}";

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
