{ vidbina-xmobar-config
, vidbina-xmonad-config
}: username: {
  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users."${username}" = {
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
