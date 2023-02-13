{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unity3d
  ];
}
