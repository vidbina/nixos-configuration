{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  nixpkgs.config.allowUnfree = true; # for spotify

  environment.systemPackages = with pkgs; [
    mpv
    playerctl
    spotify
    vlc
    youtube-dl
  ];
}

