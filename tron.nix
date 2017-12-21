{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minicom
    kicad
    xoscope
  ];
}
