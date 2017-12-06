{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    biber
    evince
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    libreoffice
    (texlive.combine { inherit (texlive)
      biblatex
      scheme-basic
      collection-basic
      collection-fontsrecommended
      collection-langeuropean
      collection-latexextra
      collection-latexrecommended
      IEEEtran
      invoice
      logreq
      realscripts
      xetex
      xetex-def
      xltxtra;
    })
    qpdfview
    xournal
    xpdf
  ];

  services.dictd = {
    enable = true;
    DBs = with pkgs.dictdDBs; [
      deu2eng
      eng2deu
      nld2eng
      eng2nld
      wordnet
      wiktionary
    ];
  };
}

