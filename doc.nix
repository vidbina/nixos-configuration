{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    lmodern
    (texlive.combine { inherit (texlive) scheme-basic collection-basic; })
  ];
}

