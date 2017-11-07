{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    irssi
    telegram-cli
    tdesktop
  ];
}
