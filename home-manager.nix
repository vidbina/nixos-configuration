{ home-manager }: home-manager.nixosModules.home-manager {
  home-manager = {
    useGlobalPackages = true;
    useUserPackages = true;
  };
}
