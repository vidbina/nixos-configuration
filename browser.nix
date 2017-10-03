{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    torbrowser
  ];
}
