{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    calcurse
    khal
    nextcloud-client
    obsidian
    planner
    tasksh
    taskwarrior
    timewarrior
    vdirsyncerStable
    vym
  ];
}
