{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cool-retro-term
    termite
  ];

  services.urxvtd.enable = true;
}
