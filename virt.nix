{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minikube
  ];

  virtualisation.virtualbox = {
    guest = {
      enable = true;
    };
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
