{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffcast
    ffmpeg-full
    minitube
    mpv
    playerctl
    v4l-utils
    vlc
  ];
}
