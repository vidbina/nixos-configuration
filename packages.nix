{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (apvlv.overrideDerivation (oldAttrs: {
        installPhase = ''
          # binary
          mkdir -p $out/bin
          cp src/apvlv $out/bin/apvlv

          # displays pdfStartup.pdf as default pdf entry
          mkdir -p $out/share/doc/apvlv/
          cp ../Startup.pdf $out/share/doc/apvlv/Startup.pdf
          cp ../main_menubar.glade $out/share/doc/apvlv/main_menubar.glade
        '';
    }))
    chromium
    conky
    curl
    darcs
    dmenu
    dzen2
    git
    git-lfs
    gnome3.eog
    gnumake
    gnupg21
    inkscape
    kicad
    mc
    neovim
    oh-my-zsh
    okular
    pass
    pstree
    rstudio
    st
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    w3m
    wget
    xclip
    xorg.xev
    xorg.xmodmap
  ];
}
