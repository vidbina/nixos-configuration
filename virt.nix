{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dive
    docker_compose
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

  users.users.vidbina.extraGroups = [ "docker" ];

  virtualisation = {
    docker = {
      enable = true;
    };
  };
}
