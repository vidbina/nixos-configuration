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
    ibus-with-plugins
    htop
    python36
    vagrant
    packer
    stellarium
  ];

  i18n.inputMethod = {
    enabled = "ibus";
    ibus = {
      engines = with pkgs.ibus-engines; [
        uniemoji
      ];
    };
  };
}
