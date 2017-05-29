{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    tetex
    lmodern
    (texlive.combine { inherit (texlive) scheme-basic xetex; })
  ];
}

