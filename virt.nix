{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    dive
    docker-compose
  ];

  boot = rec {
    kernelModules = [
      "virtio"
      "virtio_pci"
      "virtio_ring"
      "virtio_net"
    ];

    extraModulePackages = [
    ];
  };

  users.users = (lib.genAttrs [ config.my-config.handle ] (username: {
    extraGroups = [ "docker" ];
  }));

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        buildkit = true;
      };
    };
  };
}
