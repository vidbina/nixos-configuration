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
