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

    vidbina-xmobar-config = {
      url = github:vidbina/xmobar-configuration/experiment-nix-flake;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , vidbina-xmobar-config
    } @ args:
    let
      targetConfig = (target: config: (import (./targets + "/${target}")
        {
          inherit
            nixpkgs
            nixos-hardware
            home-manager;
        }
        (nixpkgs.lib.recursiveUpdate config {
          config.networking = {
            hostName = target;
            domain = "bina.me";
          };
        })));
      userConfig = (import ./home-configuration.nix {
        inherit vidbina-xmobar-config;
      });
    in
    {
      nixosConfigurations = {
        dell-xps-9360 = (targetConfig "dell-xps-9360") (userConfig "vidbina");
      };
    };
}
