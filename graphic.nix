{ config, pkgs, ... }:

let
  # /nixpkgs points to a local clone of the nixpkgs repository
  fontforge-dev = pkgs.callPackage /nixpkgs/pkgs/tools/misc/fontforge {
    withSpiro = true;
    withGTK = true;
  };
  # http://nixos.org/channels/nixos-unstable/nixexprs.tar.xz
  unstable = import (
    fetchTarball
      https://d3g5gsiof5omrk.cloudfront.net/nixos/unstable/nixos-17.09pre113094.0e5ff82954/nixexprs.tar.xz
  ) {};
in
{
  environment.systemPackages = with pkgs; [
    aseprite-unfree
    blender
    dia
    #fontforge-dev
    gimp
    glxinfo # test utils for OpenGL
    #gmsh
    graphviz
    imagemagick
    inkscape
    krita
    plantuml
    scribus
  ];
}
