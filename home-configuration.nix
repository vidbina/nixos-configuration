{ vidbina-xmobar-config
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

      xdg.mimeApps.defaultApplications = {
        "text/html" = [ "xsel-web.desktop" ];
        "x-scheme-handler/http" = [ "xsel-web.desktop" ];
        "x-scheme-handler/https" = [ "xsel-web.desktop" ];
        "x-scheme-handler/ftp" = [ "xsel-web.desktop" ];
      };
    };
  };
}
