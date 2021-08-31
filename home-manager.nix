{ ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.vidbina = {
      programs = {
        home-manager.enable = true;
      };
    };
  };
}
