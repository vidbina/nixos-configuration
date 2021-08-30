{
  description = "System configurations for David Asabina";

  inputs = {
    nixpkgs = {
      url = github:vidbina/nixpkgs/current-21.05;
    };

    nixos-hardware = {
      url = github:NixOS/nixos-hardware/master;
    };
  };

  outputs = { self, nixpkgs, nixos-hardware }:
    let
      targetToConfig = (targetDir: (import (./targets + "/${targetDir}") {
        inherit nixpkgs nixos-hardware;
      }));
    in
    {
      nixosConfigurations.dell-xps-9360 = targetToConfig ("dell-xps-9360");
    };
}
