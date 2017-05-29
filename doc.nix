{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    tetex
    #lmodern
    texLive
    #(texlive.combine { inherit (texlive) scheme-basic xetex; })
  ];
}

