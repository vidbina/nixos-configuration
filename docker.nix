{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker_compose
  ];

  virtualisation.docker.enable = true;
}

