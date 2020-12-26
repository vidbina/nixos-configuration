{ config, pkgs, ... }:

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
