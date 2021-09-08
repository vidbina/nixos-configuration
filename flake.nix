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
    {
      nixosConfigurations = {
        dell-xps-9360 = nixpkgs.lib.nixosSystem {
          #inherit system;
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.dell-xps-13-9360
            ./targets/dell-xps-9360/hardware-configuration.nix

            home-manager.nixosModules.home-manager
            {
              config.home-manager = {
                users = {
                  vidbina = {
                    home = {
                      file = vidbina-xmobar-config.nixosModule;
                    };
                  };
                };
              };
            }

            ./base.nix

            ./users.nix

            ./utils.nix

            # basics
            ./dev.nix
            ./emacs.nix
            ./vim.nix
            ./fonts.nix
            ./interfacing.nix
            ./terminal.nix
            ./net.nix

            # X
            ./x.nix
            ./xmonad.nix

            # other
            ./audio.nix
            ./browser.nix
            ./cad.nix # CAD tools (mostly 3d)
            ./chat.nix
            ./crypto.nix
            ./doc.nix
            #./eid.nix       # eID packages
            ./games.nix
            ./graphic.nix # tools for graphics editing and design
            ##./i3.nix
            ./mail.nix
            ./math.nix
            ./media.nix
            ./productivity.nix
            ./sec.nix
            #./temp.nix
            ./tron.nix # tools for electronics engineering
            #./unity3d.nix
            ./virt.nix

            ./home-configuration.nix
          ];
        };
      };
    };
}
