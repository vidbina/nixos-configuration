{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    fontforge
    fontforge-gtk
    gimp
    inkscape
  ];
}
