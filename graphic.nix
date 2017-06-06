{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    gimp
    inkscape
  ];
}
