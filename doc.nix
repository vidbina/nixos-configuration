{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pandoc
    haskellPackages.pandoc-citeproc
    tetex
    texlive
  ];
}

