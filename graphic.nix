{ config, pkgs, ... }:

let
  # http://nixos.org/channels/nixos-unstable/nixexprs.tar.xz
  unstable = import (
    fetchTarball
    https://d3g5gsiof5omrk.cloudfront.net/nixos/unstable/nixos-17.09pre113094.0e5ff82954/nixexprs.tar.xz
  ) {};
in
{
  environment.systemPackages = with pkgs; [
    blender
    glxinfo
    gimp
    imagemagick
    inkscape
    fontforge-gtk
  ];
}
