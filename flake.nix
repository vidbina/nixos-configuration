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

    sops-nix = {
      url = github:Mic92/sops-nix;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , sops-nix
    } @ args:
    let
      # TODO: Use flake-utils to do this well
      mkLinuxSystem = { target, module }: nixpkgs.lib.nixosSystem {
        #inherit system;
        system = "x86_64-linux";
        modules = [
          ./base.nix
          (./. + "/targets/${target}/hardware-configuration.nix")
          (./. + "/targets/${target}/custom.nix")
          module
          sops-nix.nixosModules.sops

          # NOTE: Define after importing users.nix (because of my-config dep)
          ({ config, lib, ... }: {
            config.networking.hostName = "vidbina-${target}";
          })

          ({ ... }: {
            nixpkgs.overlays = [
              # https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-1075818028
              (self: super: {
                nixos-option =
                  let
                    flake-compact = super.fetchFromGitHub {
                      owner = "edolstra";
                      repo = "flake-compat";
                      rev = "12c64ca55c1014cdc1b16ed5a804aa8576601ff2";
                      sha256 = "sha256-hY8g6H2KFL8ownSiFeMOjwPC8P0ueXpCVEbxgda3pko=";
                    };
                    prefix = ''(import ${flake-compact} { src = ~/src/vidbina/nixos-configuration; }).defaultNix.nixosConfigurations.${target}'';
                  in
                  super.runCommandNoCC "nixos-option" { buildInputs = [ super.makeWrapper ]; } ''
                    makeWrapper ${super.nixos-option}/bin/nixos-option $out/bin/nixos-option \
                      --add-flags --config_expr \
                      --add-flags "\"${prefix}.config\"" \
                      --add-flags --options_expr \
                      --add-flags "\"${prefix}.options\""
                  '';
              })
            ];
          })
        ];
      };
      targets = [ "dell-xps-9360" "dell-precision-5560" ];
      hardwareModules = with nixos-hardware.nixosModules; {
        dell-xps-9360 = dell-xps-13-9360;
        dell-precision-5560 = dell-precision-5530;
      };
    in
    {
      nixosConfigurations = (nixpkgs.lib.genAttrs targets
        (target: mkLinuxSystem {
          inherit target;
          module = hardwareModules."${target}";
        }));
    };
}
