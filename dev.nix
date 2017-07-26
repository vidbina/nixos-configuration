{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glibc
    stdenv
    cmakeCurses
  ];

  sound.mediaKeys.enable = true;
}
