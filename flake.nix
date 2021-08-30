{
  description = "System configurations for David Asabina";

  inputs = {
    nixpkgs = {
      url = github:vidbina/nixpkgs/current-21.05;
    };

    nixos-hardware = {
      url = github:NixOS/nixos-hardware/master;
    };

    # TODO: Keep home-manager version on-par with nixpkgs version
    home-manager = {
      url = github:nix-community/home-manager/release-21.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager }:
    let
      targetToConfig = (targetDir: (import (./targets + "/${targetDir}") {
        inherit nixpkgs nixos-hardware home-manager;
      }));
    in
    {
      nixosConfigurations.dell-xps-9360 = targetToConfig ("dell-xps-9360");
    };
}
