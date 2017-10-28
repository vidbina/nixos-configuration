{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    libreoffice
    (texlive.combine { inherit (texlive)
      scheme-basic
      collection-basic
      collection-fontsrecommended
      collection-langeuropean
      collection-latexextra
      collection-latexrecommended
      invoice
      realscripts
      xetex
      xetex-def
      xltxtra;
    })
    qpdfview
    xournal
    xpdf
  ];
}

