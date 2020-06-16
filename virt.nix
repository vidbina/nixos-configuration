{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dive
    docker_compose
    #packer
    singularity
    #vagrant
    qemu
    #minikube
  ];

  virtualisation = {
    docker = {
      enable = true;
    };
    virtualbox = {
      guest = {
        enable = true;
      };
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };
}
