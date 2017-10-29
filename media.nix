{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    playerctl
    spotify
    vlc
  ];
}

