{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema
    glibc
    stdenv
    cmakeCurses
  ];

  nixpkgs.config = {
  };

  sound.mediaKeys.enable = true;
}
