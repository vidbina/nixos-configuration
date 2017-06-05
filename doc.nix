{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    (texlive.combine { inherit (texlive)
      scheme-basic
      collection-basic
      collection-fontsrecommended
      collection-langeuropean
      collection-latexextra
      collection-latexrecommended
      xetex;
    })
    xpdf
  ];
}

