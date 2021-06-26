{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    calcurse
    khal
    obsidian
    tasksh
    taskwarrior
    timewarrior
    vdirsyncerStable
    vym
  ];
}
