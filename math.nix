{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bc
    octaveFull
    gnuplot_qt
    #rstudio
  ];
}
