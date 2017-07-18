{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virtualbox
  ];

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
