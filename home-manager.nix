{ lib, specialArgs, config, options, modulesPath }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.vidbina = {
      # https://nix-community.github.io/home-manager/options.html
      programs = {
        home-manager.enable = true;
      };

      manual = {
        # Use `home-manager-help`
        html.enable = true;

        # Use `man home-configuration.nix`
        manpages.enable = true;
      };
    };
  };
}
