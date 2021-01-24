{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    calcurse
    khal
    nextcloud-client
    planner
    tasksh
    taskwarrior
    timewarrior
    vdirsyncer
    vym
  ];
}
