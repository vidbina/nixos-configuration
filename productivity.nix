{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    osmo
    calcurse
    tasksh
    taskwarrior
    timewarrior
  ];
}
