{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    packer
    vagrant
    qemu
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
