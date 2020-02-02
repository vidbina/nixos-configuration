{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dive
    docker_compose
  ];

  virtualisation.docker.enable = true;
  #virtualisation.docker.extraOptions = "--graph=\"/store/docker\"";
}
