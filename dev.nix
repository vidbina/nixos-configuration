{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema
    glibc
    stdenv
    cmakeCurses
  ];

  sound.mediaKeys.enable = true;
}
