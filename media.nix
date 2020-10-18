{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true; # for spotify

  environment.systemPackages = with pkgs; [
    ffmpeg
    minitube
    mpv
    playerctl
    v4l-utils
    vlc
    youtube-dl
  ];
}
