{ config, pkgs, stdenv, ... }:

let
  redefinedInvoice = let
    invoice = pkgs.stdenv.mkDerivation rec {
      version = "2011-10-01";
      pname = "invoice";
      tlType = "run";

      name = "${pname}-${version}";

      src = ./customPkgs/invoice-latex;
#      src = pkgs.fetchurl {
#        url = "http://mirrors.ctan.org/macros/latex/contrib/invoice.zip";
#        sha256 = "1brinirb67pssr27l4bc17y138kvkdb7adx61b627qwq1q2immqp";
#      };

      buildInputs = with pkgs; [
        tree
        #unzip
      ];

      dontBuild = true;

      unpackPhase = ''
        echo "nothing to unpack";
      '';

#      patches = [ /tmp/invoice/invoice-former/invoice.patch ];

      installPhase = ''
        mkdir -p $out/tex/latex/invoice
        cp -r $src/texinput $out/tex/latex/invoice
      '';

      meta = {
        #platforms = stdenv.lib.platforms.unix;
      };
    };
  in { pkgs = [ invoice ]; };
in
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
    pdftk
    scim
    (texlive.combine {
      inherit (texlive)
      scheme-basic

      biblatex
      collection-langeuropean
      collection-basic
      collection-fontsrecommended
      collection-latexrecommended
      #graphics-def
      etoolbox
      datetime
      fmtcount
      german
      IEEEtran
      lastpage
      layouts
      logreq
      pdfcrop
      realscripts
      tabu
      varwidth
      xetex
      xetex-def # will soon be replaced with graphics-def
      xltxtra
      xstring;
      inherit redefinedInvoice;
    })
    qpdfview
    xournal
    xpdf
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

