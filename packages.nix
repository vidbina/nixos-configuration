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
    oh-my-zsh
    okular
    pstree
    st
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    vim
    w3m
    wget
    xorg.xev
    xorg.xmodmap
  ];
}
