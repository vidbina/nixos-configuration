{ config, pkgs, ... }:
let
  visidata-vidbina = with pkgs; visidata.overrideAttrs (old: rec {
    version = "2.1.1";

    src = fetchFromGitHub {
      owner = "saulpw";
      repo = "visidata";
      rev = "v${version}";
      sha256 = "sha256:018z06bfcw0l4k2zdwbgxna9fss4wdqj64ckw5qjis14sb3zkr28";
    };
  });
  texlive-asabina = with pkgs; (texlive.combine {
    inherit (texlive)
      scheme-basic
      luatex

      IEEEtran
      background
      bashful
      collection-basic
      collection-fontsrecommended
      collection-langeuropean
      collection-langgerman
      collection-latexrecommended
      datetime
      draftwatermark
      enumitem
      eso-pic
      etoolbox
      everypage
      fmtcount
      lastpage
      latexdiff
      mdframed
      needspace
      numprint
      paracol
      pdfcrop
      pgfgantt
      soul
      tableof
      titlepic
      tocloft
      ulem
      xargs
      xetex
      xstring
      xtab
      ;
  });
in
{
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.de
    aspellDicts.en
    aspellDicts.nl
    biber
    evince
    ghostscript
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    libreoffice
    okular
    pandoc-plantuml-filter
    texlive-asabina
    pdftk
    scim
    visidata-vidbina
    xournal
    zathura
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
