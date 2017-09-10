{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    octave
    rstudio
  ];
}

