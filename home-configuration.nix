{ vidbina-xmobar-config
, username
}: {
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

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = [ "xsel-copy-url.desktop" ];
          "x-scheme-handler/http" = [ "xsel-copy-url.desktop" ];
          "x-scheme-handler/https" = [ "xsel-copy-url.desktop" ];
          "x-scheme-handler/ftp" = [ "xsel-copy-url.desktop" ];
        };
      };
    };
  };
}
