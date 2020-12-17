{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dive
    docker_compose
    qemu
    runc
    singularity
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
