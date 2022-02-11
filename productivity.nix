{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    calcurse
    khal
    tasksh
    taskwarrior
    timewarrior
    vdirsyncerStable
    vym
  ];
}
