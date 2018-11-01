{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bc
    octave
    rstudio
  ];
}

