{ nixpkgs }: nixpkgs.lib.nixosSystem {
  inherit (nixpkgs.packages.x86_64-linux) pkgs;
  system = "x86_64-linux";
  modules = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];
}
