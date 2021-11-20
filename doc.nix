{ config, pkgs, ... }:
let
  texlive-asabina = with pkgs; (texlive.combine {
    inherit (texlive)
      scheme-medium
      luatex

      atenddvi
      IEEEtran
      background
      bashful
      capt-of
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
      wrapfig
      xargs
      xetex
      xstring
      xtab
      ;
  });
in
{
  documentation = {
    dev = {
      enable = true;
    };
    man = {
      generateCaches = true;
    };
  };

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.de
    aspellDicts.en
    aspellDicts.nl
    biber
    evince
    ghostscript
    hunspell-personal
    libreoffice
    okular
    texlive-asabina
    pdftk
    scim
    visidata
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

  nixpkgs.overlays = [
    (final: prev: rec {
      hunspell-personal =
        with prev;
        let
          personal-langs = with hunspellDicts; [
            de_DE
            en_US-large
            (stdenv.mkDerivation rec {
              pname = "hunspell-dict-nl-opentaal";
              version = "2.20.19";
              src = fetchFromGitHub {
                owner = "OpenTaal";
                repo = "opentaal-hunspell";
                rev = "${version}";
                sha256 = "sha256-/rYufNGkXWH7UQDa8ZI55JtP9LM+0j7Pad8zm2tFqko=";
              };
              meta = {
                description = "Dutch dictionary for spelling checker Hunspell and Nuspell";
                homepage = "https://github.com/OpenTaal/opentaal-hunspell";
                license = {
                  fullName = "Revised BSD License and/or CC BY 3.0";
                  url = "https://github.com/OpenTaal/opentaal-hunspell/blob/${version}/LICENSE.txt";
                };
                maintainers = with maintainers; [ ];
                platforms = lib.platforms.all;
              };

              dictFileName = "nl";
              installPhase = ''
                # hunspell dicts
                install -dm755 "$out/share/hunspell"
                install -m644 ${dictFileName}.dic "$out/share/hunspell/"
                install -m644 ${dictFileName}.aff "$out/share/hunspell/"

                # myspell dicts symlinks
                install -dm755 "$out/share/myspell/dicts"
                ln -sv "$out/share/hunspell/${dictFileName}.dic" "$out/share/myspell/dicts/"
                ln -sv "$out/share/hunspell/${dictFileName}.aff" "$out/share/myspell/dicts/"
                runHook postInstall
              '';
            })
          ];
        in
        (hunspellWithDicts personal-langs).overrideAttrs (old: {
          buildCommand = ''
            ${old.buildCommand}
            cp -r ${hunspell.man}/share $out/share
          '';
        });
    })
  ];
}
