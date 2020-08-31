{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bc
    octaveFull
    #rstudio
  ];
}
