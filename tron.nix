{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minicom
    xoscope
    nextpnr
  ];
}
