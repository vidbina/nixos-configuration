{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keymon
    slop
  ];
}
