{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.de
    aspellDicts.en
    aspellDicts.nl
    biber
    evince
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    libreoffice
    (texlive.combine { inherit (texlive)
      biblatex
      collection-basic
      collection-fontsrecommended
      collection-langeuropean
      collection-latexextra
      collection-latexrecommended
      #graphics-def
      IEEEtran
      invoice
      logreq
      realscripts
      scheme-basic
      xetex
      xetex-def # will soon be replaced with graphics-def
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

