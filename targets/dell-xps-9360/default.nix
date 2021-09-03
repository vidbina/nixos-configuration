{ nixpkgs
, nixos-hardware
, home-manager
, vidbina-xmonad-config
, vidbina-xmobar-config
}: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    nixos-hardware.nixosModules.dell-xps-13-9360
    ./hardware-configuration.nix

    home-manager.nixosModules.home-manager

    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.vidbina = {
          home.file = vidbina-xmobar-config.nixosModule;

          programs = {
            home-manager.enable = true;
          };

          manual = {
            html.enable = true;
            manpages.enable = true;
          };

          xsession.windowManager.xmonad = vidbina-xmonad-config.nixosModule;
        };
      };
    }

    ../../base.nix

    ../../users.nix

    ../../utils.nix

    # basics
    ../../dev.nix
    ../../emacs.nix
    ../../fonts.nix
    ../../interfacing.nix
    ../../terminal.nix
    ../../net.nix

    # X
    ../../x.nix
    ../../xmonad.nix

    # other
    ../../audio.nix
    ../../browser.nix
    ../../cad.nix # CAD tools (mostly 3d)
    ../../chat.nix
    ../../crypto.nix
    ../../doc.nix
    #../../eid.nix       # eID packages
    ../../games.nix
    ../../graphic.nix # tools for graphics editing and design
    ##../../i3.nix
    ../../mail.nix
    ../../math.nix
    ../../media.nix
    ../../productivity.nix
    ../../sec.nix
    #../../temp.nix
    ../../tron.nix # tools for electronics engineering
    #../../unity3d.nix
    ../../virt.nix
  ];
}
