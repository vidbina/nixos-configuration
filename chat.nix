{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    irssi
    skypeforlinux
    telegram-cli
    tdesktop
  ];
}
