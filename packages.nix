{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    conky
    curl
    darcs
    dmenu
    dzen2
    git
    gnome3.eog
    gnumake
    gnupg
    inkscape
    kicad
    neovim
    oh-my-zsh
    okular
    pandoc
    haskellPackages.pandoc-citeproc
    pstree
    rstudio
    st
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    w3m
    wget
    xorg.xev
    xorg.xmodmap
  ];
}
