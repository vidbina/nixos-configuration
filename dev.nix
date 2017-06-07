{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glibc
    stdenv
    cmakeCurses
  ];
}
