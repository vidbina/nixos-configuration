# TODO: Rename to home-configuration.nix

{ lib, ... }@inputs: username: {
  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users."${username}" = with inputs; {
      home.file = vidbina-xmobar-config.nixosModule;

      # man home-configuration.nix
      programs = {
        home-manager.enable = true;
      };

      manual = {
        # Use `home-manager-help`
        html.enable = true;

        # Use `man home-configuration.nix`
        manpages.enable = true;
      };

      xsession.windowManager.xmonad = vidbina-xmonad-config.nixosModule;
    };
  };
}
