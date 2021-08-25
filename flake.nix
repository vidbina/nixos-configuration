{
  description = "System configurations for David Asabina";

  inputs.nixpkgs.url = "github:vidbina/nixpkgs/current-21.05";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.nixos-workstation = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
