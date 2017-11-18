{ config, pkgs, ... }:

{
  # TODO: cleanup later
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    exfat
    gucharmap
    ranger
    transmission
    ibus-engines.uniemoji
    python36
    vagrant
    packer
  ];
}
