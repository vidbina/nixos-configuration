{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    calcurse
    tasksh
    taskwarrior
    timewarrior
    vdirsyncer
    vym
  ];
}
