{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    osmo
    calcurse
    taskwarrior
  ];
}
