{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    packer
    vagrant
    qemu
  ];

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
