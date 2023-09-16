# https://nixos.wiki/wiki/Flakes
{
  description = "System configurations for David Asabina";

  inputs = {
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixos-23.05;
    };

    nixpkgs-bleeding = {
      url = github:NixOS/nixpkgs/master;
    };

    nixos-hardware = {
      url = github:NixOS/nixos-hardware/master;
    };

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix = {
      url = github:Mic92/sops-nix;
    };

    devenv.url = github:cachix/devenv/latest;
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-bleeding
    , nixos-hardware
    , nix-darwin
    , sops-nix
    , devenv
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
                my-nixos-option =
                  let
                    flake-compact = super.fetchFromGitHub {
                      owner = "edolstra";
                      repo = "flake-compat";
                      rev = "12c64ca55c1014cdc1b16ed5a804aa8576601ff2";
                      sha256 = "sha256-hY8g6H2KFL8ownSiFeMOjwPC8P0ueXpCVEbxgda3pko=";
                    };
                    prefix = ''(import ${flake-compact} { src = ~/src/vidbina/nixos-configuration; }).defaultNix.nixosConfigurations.${target}'';
                  in
                  super.runCommand "nixos-option" { buildInputs = [ super.makeWrapper ]; } ''
                    makeWrapper ${super.nixos-option}/bin/nixos-option $out/bin/nixos-option \
                      --add-flags --config_expr \
                      --add-flags "\"${prefix}.config\"" \
                      --add-flags --options_expr \
                      --add-flags "\"${prefix}.options\""
                  '';
              })

              (final: prev: {
                bleeding = nixpkgs-bleeding.legacyPackages.${prev.system};
                devenv = devenv.packages.${prev.system}.devenv;
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
      darwinConfiguration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.vim
          ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "x86_64-darwin";
      };
    in
    {
      nixosConfigurations = (nixpkgs.lib.genAttrs targets
        (target: mkLinuxSystem {
          inherit target;
          module = hardwareModules."${target}";
        }));

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
        modules = [ darwinConfiguration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."simple".pkgs;

      devShells."x86_64-darwin".default = self.darwinConfigurations."simple".pkgs.mkShell rec {
        name = "macbook-old-tokyo23";
        shellHook = ''echo "Here is the rotten apple!"'';
        buildInputs = with self.darwinConfigurations."simple".pkgs; [
          nixpkgs-fmt
        ];
      };
    };

}
