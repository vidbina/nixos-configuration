{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    packer
    vagrant
    qemu
  ];

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
