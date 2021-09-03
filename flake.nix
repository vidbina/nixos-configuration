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
      # TODO: Keep home-manager version on-par with nixpkgs version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vidbina-xmonad-config = {
      url = github:vidbina/xmonad-config/experiment-nix-flake;
    };

    vidbina-xmobar-config = {
      url = github:vidbina/xmobar-configuration/experiment-nix-flake;
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, vidbina-xmonad-config }:
    let
      targetToConfig = (targetDir: (import (./targets + "/${targetDir}") {
        inherit nixpkgs nixos-hardware home-manager vidbina-xmonad-config;
      }));
    in
    {
      nixosConfigurations.dell-xps-9360 = targetToConfig ("dell-xps-9360");
    };
}
