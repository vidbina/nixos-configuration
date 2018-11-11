{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    khal
    tasksh
    taskwarrior
    timewarrior
  ];
}
