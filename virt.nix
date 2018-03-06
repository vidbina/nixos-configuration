{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    packer
    vagrant
    virtualbox
  ];

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
