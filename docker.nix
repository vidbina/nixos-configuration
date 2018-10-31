{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    docker_compose
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--graph=\"/store/docker\"";
}
