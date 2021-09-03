{ lib, specialArgs, config, options, modulesPath }: {
  options = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "foo";
    };
  };

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users."${config.username}" = {
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
